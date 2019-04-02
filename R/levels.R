#' Test if a lineage go down to a specified level
#'
#' @param lineage string.
#' @param level string. One of \code{c("kingdom", "phylum", "class",
#' "order", "family", "genus", "species", "strain")} with partial matching.
#'
#' @return logical.
#' @importFrom stringr str_sub str_detect
#' @export
#'
#' @examples
#' lineage <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' is_level(lineage, "class")
#' is_level(lineage, "genus")
is_level <- function(lineage, level = c("kingdom", "phylum", "class", "order",
                               "family", "genus", "species", "strain")) {

  level <- match.arg(level)
  letter <- ifelse(level == "strain", "t", str_sub(level, end = 1))

  str_detect(lineage, paste0(letter, "__[a-zA-Z0-9_]*$"))
}

