get_file_names <- function(dir) {
    files <- list.files(dir)
    return(grep("\\.R$|\\.Rmd$|README", files, value = TRUE))
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

replace_text <- function(dir, from, to) {
    stopifnot(length(from) == length(to) | length(to) == 1)
    files <- get_file_names(dir)
    for(file in files) {
        tx <- readLines(paste0(dir, file))
        tx2 <- replace_regex_text(tx, from, to)
        writeLines(tx2, paste0(dir, file))
    }
}
