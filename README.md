
<!-- README.md is generated from README.Rmd. Please edit that file -->

# yatah

<!-- badges: start -->

[![license](https://img.shields.io/badge/license-CC0-lightgrey.svg)](https://choosealicense.com/)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![packageversion](https://img.shields.io/badge/Package%20version-0.0.0.9001-orange.svg?style=flat-square)](commits/master)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/yatah)](https://cran.r-project.org/package=yatah)
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--04--02-yellowgreen.svg)](/commits/master)
<!-- badges: end -->

The goal of yatah is to manage taxonomy when lineages are described with
strings and taxa separated with "|\*\_\_".

For instance, the well-known *Escherichia coli* could be coded as
`k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Enterobacteriales|f__Enterobacteriaceae|g__Escherichia|s__Escherichia_coli`

## Installation

<!-- You can install the released version of yatah from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("yatah") -->

<!-- ``` -->

<!-- And the development version from [GitHub](https://github.com/) with: -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("abichat/yatah")
```

## Example

``` r
library(yatah)
```

``` r
lineages <- c(
  "k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Coriobacteriales",
  "k__Bacteria|p__Bacteroidetes|c__Bacteroidia|o__Bacteroidales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales",
  "k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Enterobacteriales"
)
```

`is_level()` checks if the lineages are of the desired order. Useful
with `dplyr::filter()`.

``` r
is_level(lineages, "order")
#> [1] TRUE TRUE TRUE TRUE TRUE
```

`last_level()` extracts the last level of the lineages.

``` r
last_level(lineages)
#> [1] "Coriobacteriales"  "Bacteroidales"     "Bacillales"       
#> [4] "Lactobacillales"   "Enterobacteriales"
```

`taxtable()` computes the taxonomic table corresponding to the lineages.

``` r
taxtable(lineages)
#>    kingdom         phylum               class             order
#> 1 Bacteria Actinobacteria      Actinobacteria  Coriobacteriales
#> 2 Bacteria  Bacteroidetes         Bacteroidia     Bacteroidales
#> 3 Bacteria     Firmicutes             Bacilli        Bacillales
#> 4 Bacteria     Firmicutes             Bacilli   Lactobacillales
#> 5 Bacteria Proteobacteria Gammaproteobacteria Enterobacteriales
```
