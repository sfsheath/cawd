library(curl)
library(devtools)
library(jsonlite)

# Script to load orbis nodes and edges

# I think the best data is available via the API
fromJSON("http://orbis.stanford.edu/api/sites", simplifyVector = F) -> tmp.orbis

tmp.o.id <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.id[i] <- tmp.orbis[[i]][[2]][[1]] }

tmp.o.name <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.name[i] <- tmp.orbis[[i]][[2]][[2]] }

tmp.o.latitude <- numeric()
for (i in 1:length(tmp.orbis)) { tmp.o.latitude[i] <- as.double(ifelse(is.null(tmp.orbis[[i]][[2]][[3]]),"0",tmp.orbis[[i]][[2]][[3]])) }

tmp.o.longitude <- numeric()
for (i in 1:length(tmp.orbis)) { tmp.o.longitude[i] <- as.double(ifelse(is.null(tmp.orbis[[i]][[2]][[4]]),"0",tmp.orbis[[i]][[2]][[4]])) }

tmp.o.pleiades <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.pleiades[i] <- tmp.orbis[[i]][[2]][[5]] }

tmp.o.contributor <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.contributor[i] <-  ifelse(is.null(tmp.orbis[[i]][[2]][[6]]),"",tmp.orbis[[i]][[2]][[6]]) }

tmp.o.isport <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.isport[i] <- tmp.orbis[[i]][[2]][[7]] }

tmp.o.rank <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.rank[i] <- tmp.orbis[[i]][[2]][[8]] }


# returns {orbis_id, name, lat, lon, Pleiades ID if known, contributor, isPort (t/f), size rank(6-10)}
orbis.nodes <- data.frame(id = tmp.o.id,
                          title = tmp.o.name,
                          latitude = tmp.o.latitude,
                          longitude = tmp.o.longitude,
                          pleiades = tmp.o.pleiades,
                          contributor = tmp.o.contributor,
                          is.port = tmp.o.isport,
                          size.rank = tmp.o.rank,
                          stringsAsFactors = FALSE)

orbis.nodes$id <- as.integer(orbis.nodes$id)
#orbis.nodes$latitude <- as.double(orbis.nodes$latitude)
#orbis.nodes$longitude <- as.double(orbis.nodes$longitude)
orbis.nodes$size.rank <- as.integer(orbis.nodes$size.rank)
orbis.nodes$is.port = ifelse(orbis.nodes$is.port == 't', TRUE, FALSE)

# these are nodes that appear in the orbis.edges data loaded below but which are not available in the API
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50038,title = "x",latitude = 36.039,longitude = 34.534,pleiades = "",contributor = "", is.port = F,size.rank = 6))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50317,title = "Portus",latitude = 41.78,longitude = 12.258,pleiades = "", contributor = "", is.port = T, size.rank = 8))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50457,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50522,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50572,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50721,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50726,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50727,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50730,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50731,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50732,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50733,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50735,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50736,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50737,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50738,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50739,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50745,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50746,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50747,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50748,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50749,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50750,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50751,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50752,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50753,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50754,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50757,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50760,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50763,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50764,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50765,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50766,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50767,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50768,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50769,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50770,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50771,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50772,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50773,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))
orbis.nodes <- rbind(orbis.nodes,data.frame(id = 50774,title = "",latitude = 0,longitude = 0,pleiades = "",contributor = "", is.port = F,size.rank = 0))

# the following code, when uncommented,  will load from the API. But that only provides road and river connections
#orbis.edges <- data.frame(source = vector(), target = vector(), type = vector(), cost = vector() )
#for (i in 1:length(orbis.nodes$id)) {
# fromJSON(paste("http://orbis.stanford.edu/api/sites/",orbis.nodes$id[i], sep="")) -> X
# Sys.sleep(.5)
# orbis.edges <- rbind(orbis.edges,data.frame(source = rep(orbis.nodes$id[i],dim(X$routes)[1]),
#                                             target = X$routes[,2],
#                                             type = X$routes[,3],
#                                             cost = X$routes[,4]))
# }

# ... instead load from May, 2014 data
orbis.edges <- read.csv(curl("https://stacks.stanford.edu/file/druid:mn425tz9757/orbis_edges_0514.csv"))

use_data(orbis.nodes, overwrite = T)
use_data(orbis.edges, overwrite = T)

