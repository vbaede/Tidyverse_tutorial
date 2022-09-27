##Wrangle

library(tidyverse)

#10.2
as_tibble(iris) #to change a dataframe to a tibble

tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)
tb <- tibble( # for non-syntactic column names, use backticks `...` also in other tidyverse packages like ggplot
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)
tb
tribble( #transposed tibble
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)
tibble( # when printed, tibbles will show the first 10 rows, the data type for each column and fit nicely on the screen so hard datasets can be reviewed
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>% 
  print(n = 10, width = Inf) #display 10 rows but all columns

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df
df$x # show values in column x
df[["x"]] # show values in column x
df[[1]] # show values in first column

#10.5
mtcars

df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]