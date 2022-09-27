##Data visualization

library(tidyverse)

install.packages(c("nycflights13", "gapminder", "Lahman"))


#3.2
mpg # data frame within ggplot2, with variables displ (car engine size) and hwy (car fuel efficiency on the highway)
?mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))