#' Taxonomic tree
#'
#' Compute taxonomic tree from taxonomic table
#'
#' @param table dataframe.
#' @param collapse logical. Should node with one child be vanished? Default to TRUE.
#' @param lineage_length double. Mean lineage length. Default to 1.
#' @param root character. Name of the root if no natural root is given.
#'
#' @return
#' @importFrom ape collapse.singles write.tree read.tree
#' @importFrom stats na.omit
#' @export
#'
#' @examples
taxtree <- function(table, collapse = TRUE, lineage_length = 1, root = ""){

  ## Convert to data.frame with factor columns

  table <- as.data.frame(apply(table, 2, as.factor))

  ## Remove NA columns

  na_col <- apply(table, 2, function(x) all(is.na(x)))
  table <- table[, !na_col]

  ## Remove rows that contains NA

  table <- na.omit(table)

  ## Number of levels

  nlvl <- ncol(table)

  ## Create a root if necessary

  if(length(unique(table[, 1])) >= 2){

    table[, nlvl+1] <- as.factor(root)
    table <- table[, c(nlvl+1, 1:nlvl)]

    nlvl <- nlvl + 1
  }

  ## Labels & convert factors to unique integer

  # tiplab <- as.character(df[[ncol(df)]])
  tiplab <- levels(table[[ncol(table)]])
  table[[ncol(table)]] <- as.numeric(table[[ncol(table)]])

  count <- length(tiplab)
  nodelab <- character()

  for(i in 1:(nlvl-1)){

    nodelab <- c(nodelab, levels(table[[i]]))

    table[[i]] <- as.numeric(table[[i]]) + count

    count <- max(table[[i]])
  }

  alllab <- c(tiplab, nodelab)


  ## Edgelist

  el <- as.matrix(table[, 1:2])

  if(nlvl > 2){
    for(i in 2:(nlvl-1)){
      el <- rbind(el, as.matrix(table[, i:(i+1)]))
    }
  }

  el <- unique(unname(el))


  ## Tree

  tree <- list(edge = el, tip.label = tiplab,
               Nnode = length(nodelab), node.label = nodelab,
               edge.length = rep(lineage_length/(nlvl-1), nrow(el)))
  class(tree) <- "phylo"

  tree <- read.tree(text = write.tree(tree))

  ## Collapse

  if(collapse){
    tree <- collapse.singles(tree)
  }

  # Add a root

  tree$root.edge <- 0

  # Return

  tree
}
