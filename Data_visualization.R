##Data visualization

library(tidyverse)

install.packages(c("nycflights13", "gapminder", "Lahman"))

#3.2
mpg # data frame within ggplot2, with variables displ (car engine size) and hwy (car fuel efficiency on the highway)
?mpg
# displ: engine displacement in litres
# hwy: highway miles per gallon
# cyl: number of cylinders

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# negative relationship between hwy and displ, lower displ gives higher hwy and vv

#3.2.4.
ggplot(data = mpg) # empty plot
dim(mpg) # 234 rows by 11 columns
?mpg #drv: the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
ggplot(mpg) + 
  geom_point(aes(hwy, cyl)) # cyl is discrete data, scatterplot not useful
ggplot(mpg) + 
  geom_point(aes(class, drv)) # class is categorical data, scatterplot not useful

#3.3
ggplot(mpg) + 
  geom_point(aes(displ, hwy, colour = class))
