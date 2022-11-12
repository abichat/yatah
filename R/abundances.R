#' Abundance table for 199 samples.
#'
#' A dataset containing the abundances of 1585 lineages among 199 patients.
#'
#' @format A data.frame with 1585 rows and 200 variables:
#' \describe{
#'   \item{lineages}{lineage (string)}
#'   \item{XXX}{abundance of each lineage in the sample XXX (double)}
#' }
#' @keywords datasets
#' @source Zeller et al., 2014 (\doi{10.15252/msb.20145645}),
#' Pasolli et al., 2017 (\doi{10.1038/nmeth.4468}).
#' @examples
#' dim(abundances)
#' abundances[1:5, 1:7]
"abundances"
