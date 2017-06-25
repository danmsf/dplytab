# dplytab
A simple way to create multi-level statistic tables that integrates with the dplyr syntax.

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

*Note: The table will be arranged in the order the variables are provided*
