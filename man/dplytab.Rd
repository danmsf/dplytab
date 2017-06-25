\name{dplytab}
\alias{dplytab}
\title{dplytab}
\usage{
dplytab(data, row_by = , col_by = )
}
\arguments{
\item{data}{A data frame or tbl.}
\item{row_by}{Character vector of variables to be in the rows of the table in order of appearance}
\item{col_by}{Character vector of variables to be in the columns of the table in order of appearance}
}
\description{
Multi-dimensional reporting tables which naturally extends the `dplyr` syntax.
It should also print nicely to html.
}
\examples{

# Make some dummy variables
irist <- cbind(iris, dum = c(rep(0,75),rep(1,75)), dum2 = c(rep("a",45),rep("b",105)))


irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length), funs(n(),sd, mean)) %>%
  dplytab( row_by = c("dum2", "Species")
          ,col_by = c("dum"))

}
