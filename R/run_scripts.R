#' @export
run_R <- function(x) {
    source(x)
    rm_globals()
}

#' @export
run_Rmd <- function(x,
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
    rm_globals()

}

# Helper function to clean environment
rm_globals <- function() {
    x <- ls(pos = ".GlobalEnv")
    rm(list = x, pos = ".GlobalEnv")
}
