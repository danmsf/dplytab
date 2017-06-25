# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'
# require(dplyr)
# require(tidyr)

#
#
# library(lazyeval)

require(tidyr)

dplytab <- function(data, row_by , col_by , evalvars=NA) {
  varnames <- names(data)
  if (is.na(evalvars)) {
    evalvars <- varnames[!(varnames %in% c(row_by, col_by))]
  }
  gather_(data, key= 'key_var', value = 'value_var', evalvars ) %>%
    unite_(col = "col_var",c(col_by, 'key_var'),remove = T) %>%
    spread( col_var, value_var, fill = NA) %>%
    select(.,c(row_by, names(.)) ) %>% arrange_(row_by)
}



irist <- iris
irist <- cbind(irist, dum = c(rep(0,75),rep(1,75)),dum2 = c(rep("a",45),rep("b",105)))

stat <- irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length), funs(sd))

irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length), funs(n(),sd, mean)) %>%
  dplytab(row_by=c("dum2", "Species")
          ,col_by = c("dum"))



irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length), funs(n(),sd, mean)) %>%
  dplytab(row_by=c("dum2", "Species") )
