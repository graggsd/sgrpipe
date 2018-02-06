run_dotR <- function(x) {
    source(x)
}

run_dotRmd <- function(x,
                       out_dir = "../results",
                       output_format = "html_document",
                       ...) {
    if (output_format == "html_document") {
        output_file <- paste0(out_dir, "/", sub("\\.Rmd$", ".html", x))
    }

    rmarkdown::render(input = x,
                      output_file = output_file,
                      output_format = output_format,
                      ...)
}

# Helper function to clean environment
rm_globals <- function() {
    x <- ls(pos = ".GlobalEnv")
    rm(list = x, pos = ".GlobalEnv")
}

# From:
# https://stackoverflow.com/questions/7505547/detach-all-packages-while-working-in-r
detachAllPackages <- function() {

    basic.packages <- c("package:stats", "package:graphics",
                        "package:grDevices", "package:utils",
                        "package:datasets","package:methods",
                        "package:base", "package:sgrpipe")

    package.list <-
        search()[ifelse(unlist(gregexpr("package:", search())) == 1,
                        TRUE,
                        FALSE)]

    package.list <- setdiff(package.list, basic.packages)

    if (length(package.list) > 0)  {
        for (package in package.list) detach(package, character.only = TRUE)
    }

}

#' @export
clear_workspace <- function(){
    detachAllPackages()
    rm_globals()
}

#' Launches scripts from \code{.R} or \code{.Rmd} files
#'
#' Depending on the type of file, the function will source code from a \code{.R}
#' file or render a document from a \code{.Rmd}.
#'
#' @param x name of file
#' @param out_dir location in which to store documents compiled from \code{.Rmd}
#' files
#' @param output_format format in which to compile a \code{.Rmd} document
#' @param ... additional parameters to pass to \code{rmarkdown::render} when
#' rendering a \code{.Rmd} file
#' @return NULL
#'
#' This function is meant to facilitate launching a series of preprocessing,
#' data exploration, and analysis scripts in R. After each script is run,
#' any existing global variables are removed; therefore, data passed from one
#' script to another should be outputed as an intermediate .RData file.
#'
#' @export
run_R <- function(x,
                  out_dir = "../results",
                  output_format = "html_document",
                  ...) {

    # Remove globals and detach non-base packages before launching the
    # script
    clear_workspace()

    if (grepl("\\.R$", x)) {
        run_dotR(x = x)
    } else if (grepl("\\.Rmd", x)) {

        run_dotRmd(x = x,
                   out_dir = out_dir,
                   output_format = output_format,
                   ...)
    }

    # Remove globals and detach non-base packages before launching the
    # script
    clear_workspace()

}

