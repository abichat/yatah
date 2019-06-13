.onLoad <- function(libname, pkgname){
  options(yatah_sep = "\\|")
}

#' Ranks
#'
#' Named vector of ranks
#'
.ranks <- c(k = "kingdom", p = "phylum", c = "class", o = "order",
            f = "family", g = "genus", s = "species", t = "strain")


#' Characters allowed in lineages
#'
.allchr <- "[a-zA-Z0-9_\\-\\.\\[\\]]"


