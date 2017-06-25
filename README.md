# dplytab
A simple way to create multi-level statistic tables that integrates with the dplyr syntax.

## Motivation
This is sorely missing from the `tidyverse`. There are a few multi-dimensional table creating packages and functions, notably `ftable` and the `tables` package. But I find this to be a more natural extension to the `dplyr` workflow process, and I need something that will easily `knit` to html.

## General Description
So far its just a simple wrapper around some `tidyr` commands that reshape the data into the desired multi-table structure.
Next step is to add/fix headers, and enhance the options....

## Usage

For a brief example try the code below :

Based on `iris` - I add another 2 random dimensions:

```r
irist <- cbind(iris
                ,dum = c(rep(0,75),rep(1,75))
                ,dum2 = c(rep("a",45),rep("b",105)))
```


Now lets use `dplyr` syntax to create a few statistics by the dimensions and pipe it along to `dplyab`:

```r
irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length), funs(n(),sd, mean)) %>%
  dplytab( row_by = c("dum2", "Species")
          ,col_by = c("dum"))
```

And this can easily extend to multiple analysis variables as well. For example:

```r
irist %>%
  group_by(Species, dum, dum2) %>%
  summarise_at(vars(Sepal.Length, Sepal.Width), funs(n(),sd, mean)) %>%
  dplytab( row_by = c("dum2", "Species")
          ,col_by = c("dum"))
```

## General Notes
* The table will be arranged in the order the variables are provided
* All Coloumn and row variables need to be provided (currently)

## Improvements
Next stages include:
* Defining a class and print method for `knitr`
* Adding options to the order of the statistics displayed
* Adding totals and subtotals to row and/or coloumn statistics
