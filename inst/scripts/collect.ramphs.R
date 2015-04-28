require(cawd)
require(devtools)
require(plyr)
require(dplyr) # recommended to load plyr first
require(jsonlite)
require(sp)
require(spatstat)

jamphs <- fromJSON("./inst/extdata/roman-amphitheaters.geojson")

ramphs = data.frame(jamphs$features$id,
                    jamphs$features$properties$title,
                    jamphs$features$properties$label,
                    jamphs$features$properties$buildingtype,
                    jamphs$features$properties$private,
                    jamphs$features$properties$capacity,
                    jamphs$features$properties$moderncountry,
                    jamphs$features$properties$chronogroup,
                    jamphs$features$properties$created,
                    jamphs$features$properties$lastuse$date,
                    jamphs$features$properties$wilsonpopulation,
                    jamphs$features$properties$wikipedia,
                    jamphs$features$properties$pleiades,
                    jamphs$features$properties$dimensions$`exterior-major`,
                    jamphs$features$properties$dimensions$`exterior-minor`,
                    jamphs$features$properties$dimensions$`arena-major`,
                    jamphs$features$properties$dimensions$`arena-minor`,
                    is.na(jamphs$features$properties$exclude) # switch semantics to include == T rather than exclude
                    )
names(ramphs) <- c("id","title","label","type","private",
                   "capacity","mod.country","chrono.grp","created","last.use",
                   "city.population","wikipedia","pleiades",
                   "ext.major","ext.minor","arena.major","arena.minor",
                   "include")

ramphs$longitude <- sapply(jamphs$features$geometry$coordinates,"[",1)
ramphs$latitude  <- sapply(jamphs$features$geometry$coordinates,"[",2)
ramphs$elevation <- sapply(jamphs$features$geometry$coordinates,"[",3)

ramphs <- join(ramphs,plyr::count(ramphs,"type"))
names(ramphs)[names(ramphs) == 'freq'] <- 'freq.type'
ramphs$type <- ordered(reorder(ramphs$type,ramphs$freq.type))

ramphs <- join(ramphs,plyr::count(ramphs,"mod.country"))
names(ramphs)[names(ramphs) == 'freq'] <- 'freq.mod.country'
ramphs$mod.country <- ordered(reorder(ramphs$mod.country,ramphs$freq.mod.country))

ramphs <- join(ramphs,plyr::count(ramphs,"chrono.grp"))
names(ramphs)[names(ramphs) == 'freq'] <- 'freq.chrono.grp'
ramphs$chrono.grp <- ordered(reorder(ramphs$chrono.grp,ramphs$freq.chrono.grp))
ramphs$chrono.grp <- ordered(ramphs$chrono.grp,c("Republican",
                              "Julius Caesar",
                              "Augustan",
                              "Julio-Claudian",
                              "Neronian",
                              "Vespasianic",
                              "Flavian",
                              "First Century",
                              "Late1stEarly2nd",
                              "Hadrianic",
                              "Second Century",
                              "Late Second Century",
                              "Severan",
                              "Post-Severan",
                              "Fourth Century",
                              "Imperial"))

 ramphs <- within(ramphs,elevation.quartile <- cut(elevation, quantile(elevation, probs=0:4/4), include.lowest=TRUE, labels=FALSE))

# calculate nearest vectors
ramphs.distances <- spDists(as.matrix(ramphs[c("longitude","latitude")]),as.matrix(ramphs[c("longitude","latitude")]),longlat = TRUE)
ramphs$nearest <- apply(ramphs.distances,2,sort)[2,]
ramphs$nearest.second <- apply(ramphs.distances,2,sort)[3,]
ramphs$nearest.third <- apply(ramphs.distances,2,sort)[4,]
ramphs$nearest.fifth <- apply(ramphs.distances,2,sort)[6,]
ramphs$nearest.tenth <- apply(ramphs.distances,2,sort)[11,]

# calculate nearest in relation to Orbis sites
ramphs.nearest.orbis <- spDists(as.matrix(filter(orbis.nodes,size.rank >=9)[c("longitude","latitude")]),as.matrix(ramphs[c("longitude","latitude")]),longlat = TRUE)
ramphs$nearest.orbis9 <- apply(ramphs.nearest.orbis,2,sort)[1,]

ramphs.distances.orbis <- spDists(as.matrix(filter(orbis.nodes,size.rank >=8)[c("longitude","latitude")]),as.matrix(ramphs[c("longitude","latitude")]),longlat = TRUE)
ramphs$nearest.orbis8 <- apply(ramphs.distances.orbis,2,sort)[1,]

#ramphs.distances.quarries <- spDists(as.matrix(oxrep.quarries[c("longitude","latitude")]),as.matrix(ramphs[c("longitude","latitude")]),longlat = TRUE)
#ramphs$quarries.nearest <- apply(ramphs.distances.quarries,2,sort)[1,]

# clustering
ramphs$kmeans.cluster <- kmeans(dplyr::select(ramphs,latitude, longitude),10)$cluster
ramphs$kmeans.cluster.neighbors <- kmeans(dplyr::select(ramphs,latitude, longitude, nearest),10)$cluster

# impute capacities

ramphs$imputed.capacity <- ifelse(is.na(ramphs$capacity),10000,ramphs$capacity)

# temporary spatial.dataframe
X.sp <- ramphs
coordinates(X.sp) <- ~longitude + latitude
proj4string(X.sp) <- CRS("+proj=longlat +datum=WGS84")

# in a senatorial province?
ramphs$prov.type <- ifelse(is.na(over(X.sp, awmc.senatorial.sp, fn = NULL)), ifelse(ramphs$mod.country =="Italy","italy","imperial"), "senatorial")

# spatial
ramphs.sp <- ramphs
coordinates(ramphs.sp) <- ~longitude + latitude
proj4string(ramphs.sp) <- CRS("+proj=longlat +datum=WGS84")



longitudeExtent <- c(-9, 44)
latitudeExtent <- c(31, 56)
tmp.ppp <- as.ppp(dplyr::select(ramphs, longitude,latitude),owin(longitudeExtent,latitudeExtent))

#expand owin for analysis
tmp.owin <- expand.owin(spatstat::convexhull(tmp.ppp), distance = .8)

ramphs.ppp <- as.ppp(dplyr::select(ramphs, longitude,latitude, imputed.capacity),W = tmp.owin)

use_data(ramphs, overwrite = T)
use_data(ramphs.sp, overwrite = T)


# cleanup
rm(X.sp)
rm(jamphs)



