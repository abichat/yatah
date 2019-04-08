#' Extract the last clade of a lineage
#'
#' @param lineage string. Vector of lineages.
#' @param same logical. Does the lineage have the same depth? Default to TRUE.
#'
#' @return A string. The last clades of the given lineages.
#' @importFrom stringr str_count str_remove
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' last_clade(c(lineage1, lineage2))
last_clade <- function(lineage, same = TRUE) {
  if (same) {
    if (!all(str_count(lineage, "__") == str_count(lineage[1], "__"))) {
      stop("Lineages don't have the same depth")
    }
  }

  str_remove(lineage, ".*__")
}


#' Extract the last rank of a lineage
#'
#' @param lineage string. Vector of lineages.
#' @param same logical. Does the lineage have the same depth? Default to TRUE.
#'
#' @return A string. The last rank of the given lineages.
#' @importFrom stringr str_count str_remove
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' last_rank(c(lineage1, lineage2))
last_rank <- function(lineage, same = TRUE) {
  if (same) {
    if (!all(str_count(lineage, "__") == str_count(lineage[1], "__"))) {
      stop("Lineages don't have the same depth")
    }
  }

  ranks <- c(k = "kingdom", p = "phylum", c = "class", o = "order",
             f = "family", g = "genus", s = "species", t = "strain")

  letter <- str_sub(str_remove(lineage, "__[a-zA-Z0-9_]*$"), start = -1)

  unname(ranks[letter])
}

