#' @export
render_DT <- function(table,
                      table_name = "default"){

    safeLoadPkg("DT")
    return(
        DT::datatable(table,
                      extensions = c("Buttons", "FixedColumns", "Scroller"),
                      escape = FALSE,
                      options = list(
                          dom = "Bfrtip",
                          buttons = list(I("colvis"),
                                         list(extend="csv",
                                              filename = table_name)),
                          autoWidth = TRUE,
                          columnDefs = list(list(width = '20px',
                                                 targets = c(1:ncol(table)))),
                          scrollX = TRUE,
                          fixedColumns = list(leftColumns = 2),
                          deferRender = TRUE,
                          scroller= TRUE,
                          scrollY = 500))
    )
}
