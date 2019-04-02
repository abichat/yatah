#' Test if a lineage go down to a specified level
#'
#' @param lineage string. Vector of lineages.
#' @param level string. One of \code{c("kingdom", "phylum", "class",
#' "order", "family", "genus", "species", "strain")} with partial matching.
#'
#' @return logical.
#' @importFrom stringr str_sub str_detect
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' is_level(c(lineage1, lineage2), "class")
#' is_level(c(lineage1, lineage2), "order")
is_level <- function(lineage,
                     level = c("kingdom", "phylum", "class", "order",
                               "family", "genus", "species", "strain")) {
    level <- match.arg(level)
    letter <- ifelse(level == "strain", "t", str_sub(level, end = 1))

    str_detect(lineage, paste0(letter, "__[a-zA-Z0-9_]*$"))
  }


#' Extract the last level of a lineage
#'
#' @param lineage string. Vector of lineages.
#' @param same logical. Do the lineage must be at the same depth? Default to TRUE.
#'
#' @return A string. The last levels of the given lineages.
#' @importFrom stringr str_count str_remove
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' last_level(c(lineage1, lineage2))
last_level <- function(lineage, same = TRUE) {
  if (same) {
    if (!all(str_count(lineage, "\\|") == str_count(lineage[1], "\\|"))) {
      stop("Lineages don't have the same depth")
    }
  }

  str_remove(lineage, ".*__")
}
