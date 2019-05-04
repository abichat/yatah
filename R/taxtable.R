#' Taxonomic table
#'
#' Compute taxonomic table from lineages.
#'
#' Duplicated lineages are removed.
#'
#' @inheritParams is_rank
#'
#' @return A data.frame with columns corresponding to different ranks.
#' @importFrom stringr str_remove_all str_split
#' @importFrom purrr map transpose
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' lineage3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"
#' taxtable(c(lineage1, lineage2, lineage3))
taxtable <- function(lineage, sep = NULL) {

  if(is.null(sep)) sep <- getOption("yatah_sep", default = "\\|")

  error_lineage(lineage, sep = sep)

  N <- depth(lineage)

  list <- str_split(str_remove_all(unique(lineage), sep), ".__")
  list <- map(list, ~ .[-1])

  list <- map(transpose(list, .names = .ranks[1:(N[1])]), unlist)
  as.data.frame(list, stringsAsFactors = FALSE)
}
