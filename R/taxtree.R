#' Taxonomic tree
#'
#' Compute taxonomic tree from taxonomic table.
#'
#'
#' @param table dataframe.
#' @param collapse logical. Should node with one child be vanished? Default
#' to TRUE.
#' @param lineage_length double. Lineage length from the root to the leaves.
#' Default to 1.
#' @param root character. Name of the root if there is no natural root.
#'
#' @return A phylo object.
#' @importFrom ape collapse.singles write.tree read.tree
#' @importFrom stats na.omit
#' @importFrom stringr str_replace_all
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' lineage3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"
#' table <- taxtable(c(lineage1, lineage2, lineage3))
#' taxtree(table)
taxtree <- function(table, collapse = TRUE, lineage_length = 1, root = ""){

  ## Remove NA columns

  na_col <- apply(table, 2, function(x) all(is.na(x)))
  table <- table[, !na_col]

  ## Return error if there is only one unique row without NA

  stopifnot(nrow(unique(na.omit(table))) > 1)

  ## Remove duplicated rows

  table <- unique(na.omit(table))

  ## Return an error if there are void ranks

  if(any(table == "")) {
    stop("Void ranks are not allowed in taxonomic trees.")
  }

  ## Convert to data.frame with factor columns

  table <- as.data.frame(apply(table, 2, as.factor), stringsAsFactors = TRUE)

  ## Number of ranks

  nrk <- ncol(table)

  ## Create a root if necessary

  if (length(unique(table[, 1])) >= 2) {
    table[, nrk + 1] <- as.factor(root)
    table <- table[, c(nrk + 1, 1:nrk)]

    nrk <- nrk + 1
  }

  ## Labels & convert factors to unique integer

  tiplab <- levels(table[[ncol(table)]])
  table[[ncol(table)]] <- as.numeric(table[[ncol(table)]])

  count <- length(tiplab)
  nodelab <- character()

  for (i in 1:(nrk - 1)) {
    nodelab <- c(nodelab, levels(table[[i]]))

    table[[i]] <- as.numeric(table[[i]]) + count

    count <- max(table[[i]])
  }

  alllab <- c(tiplab, nodelab)

  ## Edgelist

  el <- as.matrix(table[, 1:2])

  if (nrk > 2) {
    for (i in 2:(nrk - 1)) {
      el <- rbind(el, as.matrix(table[, i:(i + 1)]))
    }
  }

  el <- unique(unname(el))

  ## Tree

  tree <- list(edge = el, tip.label = tiplab,
               Nnode = length(nodelab), node.label = nodelab,
               edge.length = rep(lineage_length / (nrk - 1), nrow(el)))
  class(tree) <- "phylo"

  ## Remove brackets

  tree$tip.label <- str_replace_all(tree$tip.label, "\\[", "_ob_")
  tree$tip.label <- str_replace_all(tree$tip.label, "\\]", "_cb_")
  tree$tip.label <- str_replace_all(tree$tip.label, " ", "_sp_")

  tree$node.label <- str_replace_all(tree$node.label, "\\[", "_ob_")
  tree$node.label <- str_replace_all(tree$node.label, "\\]", "_cb_")
  tree$node.label <- str_replace_all(tree$node.label, " ", "_sp_")

  tree <- read.tree(text = write.tree(tree))

  ## Put brackets back

  tree$tip.label <- str_replace_all(tree$tip.label, "_ob_", "\\[")
  tree$tip.label <- str_replace_all(tree$tip.label, "_cb_", "\\]")
  tree$tip.label <- str_replace_all(tree$tip.label, "_sp_", " ")

  tree$node.label <- str_replace_all(tree$node.label, "_ob_", "\\[")
  tree$node.label <- str_replace_all(tree$node.label, "_cb_", "\\]")
  tree$node.label <- str_replace_all(tree$node.label, "_sp_", " ")

  ## Collapse

  if (collapse) {
    tree <- collapse.singles(tree)
  }

  ## Add a root

  tree$root.edge <- 0

  ## Return

  tree
}
