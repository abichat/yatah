#' Trim void ranks in lineages
#'
#' @details If there is a void rank amid a lineage, deeper ranks
#' will be removed. See the example with \code{lineage3}.
#'
#' @inheritParams last_clade
#' @param only_tail Logical. If \code{FALSE} (default), void ranks amid
#' lineages and subranks are removed. If \code{TRUE}, only final
#' void ranks are removed.
#'
#' @return The trimmed lineages. Depth could be different among them.
#' @importFrom stringr str_extract
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae|o__|f__"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__"
#' lineage3 <- "k__Bacteria|p__|c__Verrucomicrobiae|o__|f__"
#' trim_void(c(lineage1, lineage2, lineage3), same = FALSE)
#' trim_void(c(lineage1, lineage2, lineage3), same = FALSE, only_tail = TRUE)
trim_void <- function(lineage, same = TRUE, only_tail = FALSE) {

  error_lineage(lineage)

  if (same) depth(lineage)

  if(only_tail){
    lin <- str_remove(lineage, paste0("((^|\\|)[kpcofgst]__", "+)*$"))
  } else {
    lin <- str_extract(lineage, paste0("((^|\\|)[kpcofgst]__", .allchr, "+)*"))
  }

  return(lin)

}


#' Trim lineages until a specified rank
#'
#' @details Returns \code{NA} if a lineage is not as deep as the specified rank.
#'
#' @inheritParams last_clade
#' @inheritParams is_rank
#'
#' @return The trimmed lineages. Depth could be different among them.
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' trim_rank(c(lineage1, lineage2), rank = "phylum")
#' trim_rank(c(lineage1, lineage2), rank = "genus")
trim_rank <- function(lineage, rank = c("kingdom", "phylum", "class",
                                        "order", "family", "genus",
                                        "species", "strain"), same = TRUE) {

  error_lineage(lineage)

  rank <- match.arg(rank)

  if (same) depth(lineage)

  N <- unname(which(rank == .ranks))

  regex <- paste(names(.ranks)[seq_len(N)], collapse = "")

  str_extract(lineage,
              paste0("((^|\\|)[", regex, "]__", .allchr, "*){", N, "}"))

}
