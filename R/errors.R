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
