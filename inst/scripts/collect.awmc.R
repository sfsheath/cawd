library(devtools)
library(maptools)
library(rgdal)

# the shapefile import gives an error so go from my geojson version
# and yeah, how ugly is it that I need the full pathname

tmp.sp <- readOGR(dsn = "/Users/sfsh/Documents/roman-maps/roman_empire_bc_60_extent.geojson",layer = "OGRGeoJSON", disambiguateFIDs = T )
# there are many small polygons. remove them.
awmc.roman.territory.60bc.sp <- tmp.sp[tmp.sp$AREA > .1,]
use_data(awmc.roman.territory.60bc.sp, overwrite = T)

shapefile <- readShapeSpatial('~/Documents/roman-shapefiles/roman_empire_ad_117_extent.shp')
proj4string(shapefile) <- CRS("+proj=longlat +datum=WGS84")
shapefile -> awmc.roman.empire.117.sp
use_data(awmc.roman.empire.117.sp, overwrite = T)

shapefile <- readShapeSpatial('~/Documents/roman-shapefiles/roman_empire_ad_200_extent.shp')
proj4string(shapefile) <- CRS("+proj=longlat +datum=WGS84")
shapefile -> awmc.roman.empire.200.sp
use_data(awmc.roman.empire.200.sp, overwrite = T)

shapefile <- readShapePoly("~/Documents/awmc-maps/political_shading/persian_extent.shp")
proj4string(shapefile) <- CRS("+proj=longlat +datum=WGS84")
shapefile -> awmc.persian.extent.sp
use_data(awmc.persian.extent.sp, overwrite = T)

shapefile <- readShapePoly("~/Documents/awmc-maps/political_shading/senatorial_province.shp")
proj4string(shapefile) <- CRS("+proj=longlat +datum=WGS84")
shapefile -> awmc.roman.senatorial.sp
use_data(awmc.roman.senatorial.sp, overwrite = T)

rm(shapefile)

