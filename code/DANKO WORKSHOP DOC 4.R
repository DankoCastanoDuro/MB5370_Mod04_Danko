#Install new packages

install.packages(c("sf", "terra", "leaflet", "tmap","mgcv"))

# Load each package individually
library(sf)
library(terra)
library(leaflet)
library(tmap)
library(mgcv)
library(tidyverse)
library(readr)
library(ggplot2)

#Open dataset
copepods_raw <- read_csv("data-for-course/data-for-course/copepods_raw.csv")
View(copepods_raw)
copepods <- copepods_raw
view(copepods)

################ Check coordinates

ggplot(copepods) +
  aes(x = longitude, y = latitude, color = richness_raw) +
  geom_point()

#Non spatial analyses (aes richness)

ggplot (copepods, aes(x = latitude, y = richness_raw)) + 
  stat_smooth () +
  geom_point ()
  
#Non spatial analyses (aes region)

ggplot(copepods, aes(x = region, y = richness_raw)) +
  stat_smooth() +
  geom_point ()



################Getting going with maps

library(sf)
sdat <- st_as_sf(copepods, coords = c("longitude", "latitude"),
                 crs = 4326)
?st_as_sf

#################Coordinate reference systems

crs4326 <- st_crs(4326)
crs4326 # look at the whole CRS
crs4326$Name # pull out just the name of the crs
[1] "WGS 84"

crs4326$wkt # crs in well-known text format

#############Feature collection (points)

sdat


###############Cartography

plot(sdat["richness_raw"])

plot(sdat)

###############Thematic maps for communication
library(tmap)
#using tmap
tm_shape(sdat) +
  tm_dots(col = "richness_raw", palette = "Blues")
  

tmap_save(tm1, filename = "Richness-map.png",
          width = 600, height = 600)

##################Mapping spatial polygons as layers

#Loading shapefiles

# Load the 'sf' package
library(sf)
# Read the shapefile
aus <- st_read('C:/Users/Danko Castaño Duro/Desktop/Australia 3 semestre/Modulos 1/INTRODUCTION TO R 4/MB5370_Mod04_Danko/MB5370_Mod04_Danko/data-for-course/data-for-course/spatial-data/Aussie/Aussie.shp')
shelf <- st_read('C:/Users/Danko Castaño Duro/Desktop/Australia 3 semestre/Modulos 1/INTRODUCTION TO R 4/MB5370_Mod04_Danko/MB5370_Mod04_Danko/data-for-course/data-for-course/spatial-data/Aussie/Aussie.shp')

###########Mapping your polygons

library(tmap)
tm_shape(shelf) +
  tm_polygons()

tm_shape(shelf, bbox = sdat) +
  tm_polygons() +
  tm_shape(aus) +
  tm_polygons() +
  tm_shape(sdat) +
  tm_dots()

############ Exploring t_map

?tmap

tmap_style("beaver")
vignette('tmap-getstarted')

tmap_save()
