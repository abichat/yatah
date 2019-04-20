#' Extract the last clade of a lineage
#'
#' @param lineage string. Vector of lineages.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
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
last_clade <- function(lineage, sep = "\\|", same = TRUE) {

  error_lineage(lineage, sep = sep)

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
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
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
last_rank <- function(lineage, sep = "\\|", same = TRUE) {

  error_lineage(lineage, sep = sep)

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


#' Extract all clades present in the lineages
#'
#' @param lineages string. Vector of lineages.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
#' @param simplify logical. Should the output be a vector or a dataframe?
#'
#' @return The clades present in the lineage. Vector of ordered strings
#'  or data.frame.
#' @importFrom stringr str_split str_sub
#' @export
#'
#' @examples
#' lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
#' lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
#' all_clades(c(lineage1, lineage2))
#' all_clades(c(lineage1, lineage2), simplify = FALSE)
all_clades <- function(lineages, sep = "\\|", simplify = TRUE) {

  error_lineage(lineages, sep = sep)

  clades <- unique(unlist(str_split(lineages, pattern = sep)))

  if (simplify) {

    return(sort(str_sub(clades, start = 4)))

  } else {

    ranks <- c(k = "kingdom", p = "phylum", c = "class", o = "order",
               f = "family", g = "genus", s = "species", t = "strain")
    ranks_ <- ranks[str_sub(clades, end = 1)]
    df <-data.frame(clade = str_sub(clades, start = 4), rank = ranks_,
                    stringsAsFactors = FALSE)
    ind <- order(df$clade)

    return(df[ind, ])

  }
}


