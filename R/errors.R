#' Throw error if the string is not a lineage
#'
#' @param string string.
#' @param sep string. Rank separator. Default to \code{\\\\|} but
#' \code{;} could be used too.
error_lineage <- function(string, sep = "\\|"){
  if(!all(is_lineage(string, sep))) {
    stop(paste0("Your string is not a lineage. Maybe you have ",
                "specified the wrong separator or used special caracters."))
  }
}


#' Common depth
#'
#' Throw an error if depth is not the same across lineages.
#'
#' @param lineage string. Vector of lineages.
#' @importFrom stringr str_count
depth <- function(lineage) {
  N <- str_count(lineage, "__")
  if (!all(N == N[1])) {
    stop("Lineages don't have the same depth.")
  }
  return(N)
}
