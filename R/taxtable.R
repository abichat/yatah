#' Taxonomic table
#'
#' Compute taxonomic table from lineages.
#'
#' Duplicated lineages are removed.
#'
#' @param lineage string. Vector of lineages.
#'
#' @return A data.frame with columns corresponding to different levels.
#' @importFrom stringr str_count str_remove_all str_split
#' @importFrom purrr map transpose
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' lineage3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"
#' taxtable(c(lineage1, lineage2, lineage3))
taxtable <- function(lineage) {
  levels <- c("kingdom", "phylum", "class", "order",
              "family", "genus", "species", "strain")

  N <- str_count(lineage, "\\|")
  if (!all(N == N[1])) {
    stop("Lineages don't have the same depth")
  }

  list <- str_split(str_remove_all(unique(lineage), "\\|"), ".__")
  list <- map(list, ~ .[-1])

  list <- map(transpose(list, .names = levels[1:(N[1] + 1)]), unlist)
  as.data.frame(list, stringsAsFactors = FALSE)
}
