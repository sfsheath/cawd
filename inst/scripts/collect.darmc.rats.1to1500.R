library(devtools)
library(maptools)
library(rgdal)

# the shapefile import gives an error so go from my geojson version
# and yeah, how ugly is it that I need the full pathname

shapefile <- readShapeSpatial('~/Documents/darmc/rats_release.shp')
proj4string(shapefile) <- CRS("+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
darmc.rats.1to1500.sp <- spTransform(shapefile, CRS("+proj=longlat +datum=WGS84"))
names(darmc.rats.1to1500.sp) <- c("title",
                                 "latitude","longitude",
                                 "Q_GEO",
                                 "start.date","end.date",
                                 "Q_DATE","REMS",
                                 "count",
                                 "Q_CONTEXT",
                                 "comment",
                                 "bibliographic.citation")
use_data(darmc.rats.1to1500.sp, overwrite = T)


shapefile <- readShapeSpatial('~/Documents/darmc/roman_roads_v2008.shp')
proj4string(shapefile) <- '+proj=lcc +lat_1=43.0 +lat_2=62.0 +lat_0=30 +lon_0=10 +x_0=0 +y_0=0 +ellps=intl  +units=m +no_defs'
darmc.roman.roads.sp <- spTransform(shapefile, CRS("+proj=longlat +datum=WGS84"))
darmc.roman.roads.major.sp <- darmc.roman.roads.sp[darmc.roman.roads.sp$CLASS == "Major Road",]

use_data(darmc.roman.roads.major.sp, overwrite = T)

rm(shapefile)

