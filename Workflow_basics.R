## Workflow basics

# Tidyverse training
# Following the R for Data Science book to learn the Tidyverse at https://www.tidyverse.org/
# https://r4ds.had.co.nz/

#Libraries
library(tidyverse)

# Coding basics

1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

x <- 3 * 4
#object_name <- value

#4.2 What's in a name?
# i_use_snake_case
# otherPeopleUseCamelCase
# some.people.use.periods
# And_aFew.People_RENOUNCEconvention

x
this_is_a_really_long_name <- 2.5
this_is_a_really_long_name
r_rocks <- 2 ^ 3
r_rocks

#4.3 Calling functions
seq(1, 10)
x <- "hello world"
(y <- seq(1, 10, length.out = 5))

my_variable <- 10
my_variable
#> Error in eval(expr, envir, enclos): object 'my_variable' not found

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)
