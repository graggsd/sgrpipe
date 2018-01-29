run_dotR <- function(x) {
    source(x)
    rm_globals()
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
    rm_globals()
}

#' @export
run_R <- function(x,
                  out_dir = "../results",
                  output_format = "html_document",
                  ...) {

    if (grepl("\\.R$", x)) {
        run_dotR(x = x)
    } else if (grepl("\\.Rmd", x)) {

        run_dotRmd(x = x,
                   out_dir = out_dir,
                   output_format = output_format,
                   ...)
    }

}

# Helper function to clean environment
rm_globals <- function() {
    x <- ls(pos = ".GlobalEnv")
    rm(list = x, pos = ".GlobalEnv")
}

