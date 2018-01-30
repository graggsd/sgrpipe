
sgrpipe
=======

The goal of sgrpipe is to facilitate a simple R analysis pipeline. Currently, the function of most use is `run_R`, which will either source `.R` scritps or compile `.Rmd` files. The point is to place a series of `run_R` calls pointing to scripts in your pipeline such that they may be interactively launched when running/testing your pipeline. After the end of each call, all variables are removed from the global environment.

Installation
------------

You can install sgrpipe from github with:

``` r
# install.packages("devtools")
devtools::install_github("graggsd/sgrpipe")
```
