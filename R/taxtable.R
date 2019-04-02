#' Taxonomic table
#'
#' Compute taxonomic table from lineages.
#'
#' @param lineage string.
#'
#' @return A data.frame
#' @importFrom stringr str_count str_remove_all str_split
#' @importFrom purrr map transpose
#' @export
#'
#' @examples
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
  as.data.frame(list)
}
