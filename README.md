
<!-- README.md is generated from README.Rmd. Please edit that file -->

# yatah

<!-- badges: start -->

[![license](https://img.shields.io/badge/license-CC0-lightgrey.svg)](https://choosealicense.com/)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![packageversion](https://img.shields.io/badge/Package%20version-0.0.0.9002-orange.svg?style=flat-square)](commits/master)
[![Travis build
status](https://travis-ci.org/abichat/yatah.svg?branch=master)](https://travis-ci.org/abichat/yatah)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/abichat/yatah?branch=master&svg=true)](https://ci.appveyor.com/project/abichat/yatah)
[![Codecov test
coverage](https://codecov.io/gh/abichat/yatah/branch/master/graph/badge.svg)](https://codecov.io/gh/abichat/yatah?branch=master)
[![Last-changedate](https://img.shields.io/badge/last%20change-2019--04--03-yellowgreen.svg)](/commits/master)
<!-- [![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/yatah)](https://cran.r-project.org/package=yatah) -->
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
  "k__Bacteria|p__Bacteroidetes|c__Flavobacteriia|o__Flavobacteriales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales",
  "k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales",
  "k__Bacteria|p__Proteobacteria|c__Epsilonproteobacteria|o__Campylobacterales",
  "k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Enterobacteriales",
  "k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Pseudomonadales"
)
```

  - `is_level()` checks if the lineages are of the desired order. Useful
    with `dplyr::filter()`.

<!-- end list -->

``` r
is_level(lineages, "order")
#> [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
is_level(lineages, "species")
#> [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

  - `last_level()` extracts the last level of the lineages.

<!-- end list -->

``` r
last_level(lineages)
#> [1] "Coriobacteriales"  "Bacteroidales"     "Flavobacteriales" 
#> [4] "Bacillales"        "Lactobacillales"   "Clostridiales"    
#> [7] "Campylobacterales" "Enterobacteriales" "Pseudomonadales"
```

  - `taxtable()` computes the taxonomic table corresponding to the
    lineages.

<!-- end list -->

``` r
table <- taxtable(lineages)
table
#>    kingdom         phylum                 class             order
#> 1 Bacteria Actinobacteria        Actinobacteria  Coriobacteriales
#> 2 Bacteria  Bacteroidetes           Bacteroidia     Bacteroidales
#> 3 Bacteria  Bacteroidetes        Flavobacteriia  Flavobacteriales
#> 4 Bacteria     Firmicutes               Bacilli        Bacillales
#> 5 Bacteria     Firmicutes               Bacilli   Lactobacillales
#> 6 Bacteria     Firmicutes            Clostridia     Clostridiales
#> 7 Bacteria Proteobacteria Epsilonproteobacteria Campylobacterales
#> 8 Bacteria Proteobacteria   Gammaproteobacteria Enterobacteriales
#> 9 Bacteria Proteobacteria   Gammaproteobacteria   Pseudomonadales
```

  - `taxtree()` computes the taxonomic tree (format `phylo`) from a
    taxonomic table.

<!-- end list -->

``` r
tree <- taxtree(table)
tree
#> 
#> Phylogenetic tree with 9 tips and 6 internal nodes.
#> 
#> Tip labels:
#>  Coriobacteriales, Bacteroidales, Flavobacteriales, Bacillales, Lactobacillales, Clostridiales, ...
#> Node labels:
#> [1] "Bacteria"            "Bacteroidetes"       "Firmicutes"         
#> [4] "Bacilli"             "Proteobacteria"      "Gammaproteobacteria"
#> 
#> Rooted; includes branch lengths.
plot(tree, show.node.label = TRUE)
```

<img src="man/figures/README-taxtree-1.png" width="100%" />
