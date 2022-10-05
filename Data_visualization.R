##Data visualization

# Tidyverse training
# Following the R for Data Science book to learn the Tidyverse at https://www.tidyverse.org/
# https://r4ds.had.co.nz/

#Libraries
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
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Once you map an aesthetic, ggplot2 takes care of the rest. It selects a reasonable scale to use with the aesthetic, 
# and it constructs a legend that explains the mapping between levels and values. For x and y aesthetics, ggplot2 does not create a legend, 
# but it creates an axis line with tick marks and a label. The axis line acts as a legend; it explains the mapping between locations and values.

# so only geom_levels are given in legend. aesthetics on main level are given on axis

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
# To set an aesthetic manually, set the aesthetic by name as an argument of your geom function; i.e. it goes outside of aes().

#3.3.1 exercises
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) # color should be outside of aes
str(mpg) # see variable classes to determine categorical and continuous variables

ggplot(mpg, aes(x = displ, y = hwy, color = cty)) + # colour gradient
  geom_point() 
ggplot(mpg, aes(x = displ, y = hwy, size = cty)) + # size gradient
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy, shape = cty)) + # continuous variable cannot be mapped to a shape
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy, color = cty, size = cty)) + # both aesthetics shown
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(stroke=cty)) 
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
ggplot(mpg, aes(x = displ, y = hwy)) + # specify colour aesthetics to values of displ < 5
  geom_point(aes(colour = displ < 5)) 

#3.5 Facets
