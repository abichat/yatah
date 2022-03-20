#' Throw error if the string is not a lineage
#'
#' @inheritParams is_lineage
#' @keywords internal
error_lineage <- function(string){

  if(!all(is_lineage(string))) {
    stop(paste0("Your string is not a lineage. Maybe you have ",
                "specified the wrong separator or used special caracters."))
  }
}


#' Common depth
#'
#' Throw an error if depth is not the same across lineages.
#'
#' @inheritParams is_rank
#' @importFrom stringr str_count
#' @keywords internal
depth <- function(lineage) {
  N <- str_count(lineage, "__")
  if (!all(N == N[1])) {
    stop("Lineages don't have the same depth.")
  }
  return(N)
}
