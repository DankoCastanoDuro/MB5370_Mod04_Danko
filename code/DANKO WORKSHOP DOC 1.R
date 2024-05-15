install.packages("tidyverse")
library(tidyverse)
#DATA
mpg
#Create your first ggplot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#PLAYING WITH PLOTS
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = class)) #looks great

#PLAYING with plots 2.0
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) 
#looks very shitty playing with sizes, don’t plot a variable which is not continuous to a continuous aesthetic like size

#ALPHA PLAYS WITH TRANSPARENCY
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#SHAPE CAN ALSO BE CHANGED
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#YOU CAN ALSO DECIDE THE COLOR
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#QUESTION

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),colour = displ < 5)

#colour = displ < 5: This sets the color of the points based on a condition. 
#Points where the 'displacement' variable is less than 5 will have one color, and points where the 'displacement' variable is greater than or equal to 5 will have another color.


#COMMON ERRORS 
ggplot(data = mpg)
+ geom_point(mapping = aes(x = displ, y = hwy))
# the + should be on top line

#FACETS AND PANEL PLOTS
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)
#SPLITS DATA PER CLASS OF CARS (NOTS X & Y) EX: TYPES OF CARS PER DISPLAY AND HWY

#If you want to do this with more than one variable, then use facet_grid().
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)


#Exercise:
#1. Read ?facet_wrap. What does nrow do? What does ncol do? What other options
#control the layout of the individual panels?

#`nrow` and `ncol` in `facet_wrap` control the grid layout of panels in a faceted plot. `nrow` sets the number of rows, while `ncol` sets the number of columns. Other options like `dir`, `as.table`, and `shrink` adjust panel arrangement and scale size.

#Fitting simple lines

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displx, y = hwy)

ggplot(data = mpg) +
 geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
 # geom_point(mapping = aes(x = displ, y = hwy)) # points horrible
 geom_smooth(mappings = aes(x = displ, y = hwy)) # try smooth
line

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))



ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE,
  )


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


#Exercise:
#  1. What geom would you use to draw a line chart? A boxplot? A histogram? An area
#chart?
#  37
#2. Run this code in your head and predict what the output will look like. Then, run the
#code in R and check your predictions.
#3. Will these two graphs look different? Why/why not?


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#Transformations and Stats

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~cut, ~freq,
  "Fair", 1610,
  "Good", 4906,
  "Very Good", 12082,
  "Premium", 13791,
  "Ideal", 21551
)
demo
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")


ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))
#> Warning: `stat(prop)` was deprecated in ggplot2 3.4.0.

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )


#Aesthetic adjustments

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

#To alter transparency (alpha)
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")
#To color the bar outlines with no fill color
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) +
geom_bar(fill = NA, position = "identity")


#position = "fill" works like stacking, but makes each set of stacked bars the same height.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")
#position = "dodge" places overlapping objects directly beside one another.
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge"
           
#position = "jitter" adds a small amount of random noise to each point to avoid
#overplotting when points overlap. This is useful for scatterplots but not barplots.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter"
             
#The layered grammar of graphics

ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>,
    position = <POSITION>
  ) +
  <FACET_FUNCTION>