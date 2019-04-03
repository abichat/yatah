#' Test if a lineage goes down to a specified rank
#'
#' @param lineage string. Vector of lineages.
#' @param rank string. One of \code{c("kingdom", "phylum", "class",
#' "order", "family", "genus", "species", "strain")} with partial matching.
#'
#' @return logical.
#' @importFrom stringr str_sub str_detect
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' is_rank(c(lineage1, lineage2), "class")
#' is_rank(c(lineage1, lineage2), "order")
is_rank <- function(lineage,
                    rank = c("kingdom", "phylum", "class", "order",
                             "family", "genus", "species", "strain")) {
    rank <- match.arg(rank)
    letter <- ifelse(rank == "strain", "t", str_sub(rank, end = 1))

    str_detect(lineage, paste0(letter, "__[a-zA-Z0-9_]*$"))
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
    if (!all(str_count(lineage, "\\|") == str_count(lineage[1], "\\|"))) {
      stop("Lineages don't have the same depth")
    }
  }

  str_remove(lineage, ".*__")
}
