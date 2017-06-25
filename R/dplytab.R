# Hello, dplytab!



dplytab <- function(data, row_by , col_by , evalvars=NA) {
  varnames <- names(data)
  if (is.na(evalvars)) {
    evalvars <- varnames[!(varnames %in% c(row_by, col_by))]
  }
  tidyr::gather_(data, key= 'key_var', value = 'value_var', evalvars ) %>%
    tidyr::unite_(col = "col_var",c(col_by, 'key_var'),remove = T) %>%
    tidyr::spread( col_var, value_var, fill = NA) %>%
    dplyr::select(.,c(row_by, names(.)) ) %>% arrange_(row_by)
}

