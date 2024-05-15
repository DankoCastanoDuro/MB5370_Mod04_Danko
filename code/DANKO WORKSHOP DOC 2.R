library("tidyverse")

#Labels
#In ggplot2, you add labels with the labs() function. Let’s start with a title.
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se.e = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")

#If you need to add more text, you can use a couple of other functions:
#● subtitle adds additional detail in a smaller font beneath the title and caption adds
#text at the bottom right of the plot
#● caption adds text at the bottom right of the plot, often used to describe the source
#of the data.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of
their light weight",
    caption = "Data from fueleconomy.gov"
  )

#use labs() to replace axis labels and legend titles.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )

#Annotations
# to add text to the plot itself
#Here you can use geom_text() to add textual labels to your plots. This works in the same way as geom_point() but rather than a shape geometry it can add a label.

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_text(aes(label = model), data = best_in_class)


#Scales
#Changing the default scales on ggplot2 can help you customize your plots and improve
#communication of your results.
#Normally, ggplot2 automatically adds scales for you.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))

#ggplot2 automatically adds default scales behind the scenes.
#if you want to tweak them, you can do so by offering values to the scale
#parameters by adding numbers in the appropriate scale arguments.

#Note also that: ?scale_x_continuous() has plenty of other
#arguments, so don’t forget to explicitly state the argument you’re providing these limits for
#(e.g. limits = c(0,12)).

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous(c(0, 50)) +
  scale_y_continuous(c(0, 50)) +
  scale_colour_discrete(c(0, 50))

#Axis tick
#You can also change the ticks on your axes. 

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))

#What does seq do? Try running
seq(15, 40, by = 5)

#Similarly, you can use labels set to NULL to suppress the labels altogether. This is
#sometimes an option if you’re trying to format your plots in a particular way

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_x_continuous(labels = NULL) +
  scale_y_continuous(labels = NULL)

#Legends and colour schemes

#Sometimes you might want to change the position of your legend, perhaps to make the plot
#itself as wide as possible (e.g. put the legend underneath) or to hide it all together

#To control the overall position of the legend, you need to use a theme() setting.

base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))
base + theme(legend.position = "left")

#or we can put it in top or wherever
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))
base + theme(legend.position = "top")

#Replacing a scale
#There are two types of scales you’re mostly likely to want to switch out: continuous position
#scales and colour scales

ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() +
  scale_x_log10() +
  scale_y_log10()

#Another scale that is frequently customised is the colour scale.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))
#diffeebt color packs YIOrRd, Greens, BuPu... orSets, Set1, Set2...

#The ColorBrewer scales are documented online at http://colorbrewer2.org/. There are a
#range of different colour schemes you can import such as this, so read more about them in
#the ggplot2 cookbook: http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")

#When you have predefined colours you want to use you can set them yourself, using
#scale_colour_manual()

presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_colour_manual(values = c(Republican = "red", Democratic =
                                   "blue"))
#To use it, simply use scale_colour_viridis() provided by the viridis package

install.packages('viridis')
install.packages('hexbin')
library(viridis)
library(hexbin)
df <- tibble( # note we're just making a fake dataset so we can plot it
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() + # a new geom!
  coord_fixed()
ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis() +
  coord_fixed()

#Themes
#Now you can customize the entire theme of your plot. Themes allow you to
#change some or all of the non-data elements of your plot with a theme.

#ggplot2 has eight themes by default. Many more are included in add-on packages like
#ggthemes (https://github.com/jrnold/ggthemes), by Jeffrey Arnold.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_light()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_classic()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_dark()

#One particularly nice thing you can do is to develop your own themes simply by setting some
#or all of the arguments to theme() yourself

theme (panel.border = element_blank(),
       panel.grid.minor.x = element_blank(),
       panel.grid.minor.y = element_blank(),
       legend.position="bottom",
       legend.title=element_blank(),
       legend.text=element_text(size=8),
       panel.grid.major = element_blank(),
       legend.key = element_blank(),
       legend.background = element_blank(),
       axis.text.y=element_text(colour="black"),
       axis.text.x=element_text(colour="black"),
       text=element_text(family="Arial"))

#Saving and exporting your plots
#There are two main ways to get your plots out of R using ggplot2. ggsave() will save the
#most recent plot to your working directory

ggplot(mpg, aes(displ, hwy)) + geom_point()
ggsave("my-plot.pdf")
#> Saving 7 x 4.32 in image

#Sometimes, you’ll want to play with the dimensions of your plot, in which case you can use
#the width and height arguments to this function. Try it!
  

