#' @export
run_R <- function(x) {
    source(x)
    rm(list = ls())
}

#' @export
run_Rmd <- function(x,
                    out_dir = "../results",
                    output_format = "html_document",
                    ...) {
    if (output_format == "html_document") {
        output_file <- paste0("../results/", sub("\\.Rmd$", ".html", x))
    }

    rmarkdown::render(input = x,
                      output_file = output_file,
                      output_format = output_format,
                      ...)

}
