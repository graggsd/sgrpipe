get_file_names <- function(dir) {
    files <- list.files(dir)
    return(grep("\\.R$|\\.Rmd$", files, value = TRUE))
}

replace_regex_text <- function (x, from, to) {
    stopifnot(length(from) == length(to) | length(to) == 1)
    if (length(to) > 1) {
        for (i in 1:length(from)) {
            x <- gsub(from[i], to[i], x)
        }
    }
    else {
        for (i in 1:length(from)) {
            x <- gsub(from[i], to, x)
        }
    }
    return(x)
}

search_text <- function(x, from) {
    return(sum(sapply(from, grepl, x)) > 0)
}

#' Replaces text from all \code{.R} and \code{.Rmd} files within a given
#' directory
#'
#' This function takes a series of regular expression in \code{from} and changes
#' them to the values in \code{to} for all \code{.R} and \code{.Rmd} files
#' in the directory \code{dir}.
#'
#' @param from one or more regexes to substitute
#' @param to one or values that will substitute for regexes in \code{from}
#'
#' @return NULL
#'
#' @export
replace_text <- function(from, to, dir = "./") {
    # Stop if from and to lengths don't match
    stopifnot(length(from) == length(to) | length(to) == 1)
    # Get all .R .Rmd and README file names
    files <- get_file_names(dir)
    for(file in files) {
        # For each file, read line by line
        tx <- readLines(paste0(dir, file))
        # Re-write file only if one of the regexs in the from argument is
        # contained within a given file
        if (search_text(tx, from)) {
            tx2 <- replace_regex_text(tx, from, to)
            writeLines(tx2, paste0(dir, file))
        }
    }
}

