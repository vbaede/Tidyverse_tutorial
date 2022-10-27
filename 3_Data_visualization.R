## 3. Data visualization

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
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) # facet_grid is cleaner for 2  variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(drv ~ cyl)
#3.5.1
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) # no data for empty grids
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#3.6 Geometric objects
# left
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))
# right
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, colour = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),show.legend = FALSE)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)
#3.6.1 Exercises
#geom_line()  geom_boxplot()  geom_histogram()  geom_area()
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = FALSE, show.legend = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(se = FALSE, colour = "blue")
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(aes(group = drv), se = FALSE, colour = "blue")
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = FALSE, show.legend = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(colour=drv)) +
  geom_smooth(se = FALSE, colour = "blue")
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(colour=drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE, colour = "blue")
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour=drv))
  
#3.7 Statistical transformations
# bar charts, histograms, and frequency polygons bin your data and then plot bin counts, the number of points that fall in each bin.
# smoothers fit a model to your data and then plot predictions from the model.
# boxplots compute a robust summary of the distribution and then display a specially formatted box.

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut)) # geom_bar uses stat_count
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut)) # using stat_count instead of geom gives the same result

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity") #default stat can be overridden
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
ggplot(data = diamonds) + 
  stat_summary(mapping = aes(x = cut, y = depth), fun.min = min, fun.max = max, fun = median)

#3.7.1
?stat_summary #geom = pointrange
ggplot(data = diamonds) + 
  geom_pointrange(mapping = aes(x = cut, y = depth), stat = "summary")
?geom_col # different stat than geom_bar
?geom_bar
?stat_smooth # computes y/x: predicted value, ymin/xmin: lower pointwise CI of the mean, ymax/xmax: upper pointwise CI of the mean, SE
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop), group = 1)) # total needs to be 1
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = (after_stat(count))/(sum(after_stat(count))), fill = color))

#3.8 Position adjustments
           
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut)) #omtrek gekleurd
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut)) #coloured bars
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) #stacked coloured bars
# to change stacking, change  position through position adjustment
# position = identity
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity") #identity places object where it falls in the context of graph -> useful for 2d plots, otherwise overlapping
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity") 
# position = fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill") #each bar same height
# position = dodge, places overlapping objects beside each other
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")
# position = jitter, adds noise to prevent overplotting (points plotted on the same position, making them invisible)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

#3.8.1
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter") # add jitter
?geom_jitter # amount of jittering adjusted by parameters width and height
?geom_count # Produces datapoints with sizes related to counts
?geom_boxplot # default position adjustment is dodge2, thus only changes width, not height

#3.9 Coordinate systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip() # flips x and y axes

nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap() #sets aspect ratio for maps, when plotting spatial data

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar() # uses polar coordinates, combo of bar chart and coxcomb chart

#3.9.1
ggplot(mpg, aes(x = factor(1), fill = drv)) +
  geom_bar(width = 1) +
  coord_polar(theta = "y") # theta determines map angle x or y
?coord_polar # it is also possible to change starting point (not 12 o'clock), direction clockwise or anticlockwise, or clipping
?coord_map # more extended version of coord_quickmap which projects spherical earth on 2d plane, does not preserve straight lines compared to coord_quickmap

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() + #is the diagonal line
  coord_fixed() # fixes ratio of axes
?coord_fixed

#3.10 Layered grammar of ggplot

# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>