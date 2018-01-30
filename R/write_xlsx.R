#' Writes data to an xlsx file
#'
#' Writes data to an xlsx file. If more than one dataset is specified, multiple
#' sheets in the output xlsx file are created.
#'
#' @param datasets A list of datasets to be written to a .xlsx file
#' @param file_name Name and path of output file.
#' @param sheet_names Names of .xlsx sheets
#' @return NULL
#'
#' This function will create a .xlsx file with multiple sheets based on a list
#' of datasets specified by \code{datasets}. The names of the sheets may
#' be specified using \code{sheet_names}. Otherwise, the names contained in the
#' list of datasets will be used to name the sheets.
#'
#' This function requires installlation of the \code{xlsx}.
#'
#' @export
write_xlsx <- function(datasets, file_name, sheet_names = NULL) {

    safeLoadPkg("xlsx")

    datasets <- lapply(datasets, as.data.frame, stringsAsFactors = FALSE)

    if (is.null(sheet_names)) sheet_names <- names(datasets)
    if (is.null(sheet_names)) sheet_names <- 1:length(datasets)

    xlsx::write.xlsx(datasets[[1]],
                     file = file_name,
                     sheetName = sheet_names[1],
                     row.names = FALSE)

    if (length(datasets) > 1) {
        for (i in 2:length(datasets)) {
            xlsx::write.xlsx(datasets[[i]],
                             file = file_name,
                             sheetName = sheet_names[i],
                             append = TRUE,
                             row.names = FALSE)
        }
    }
}

# You need the suggested package for this function
safeLoadPkg <- function(pkg) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        stop("The package ", pkg, " is needed for this function to work. Please install it.",
             call. = FALSE)
    }
}