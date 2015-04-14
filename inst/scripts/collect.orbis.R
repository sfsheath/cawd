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

tmp.o.latitude <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.latitude[i] <- ifelse(is.null(tmp.orbis[[i]][[2]][[3]]),"0",tmp.orbis[[i]][[2]][[3]]) }

tmp.o.longitude <- vector()
for (i in 1:length(tmp.orbis)) { tmp.o.longitude[i] <- ifelse(is.null(tmp.orbis[[i]][[2]][[4]]),"0",tmp.orbis[[i]][[2]][[4]]) }

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
orbis.nodes$latitude <- as.integer(orbis.nodes$latitude)
orbis.nodes$longitude <- as.integer(orbis.nodes$longitude)
orbis.nodes$size.rank <- as.integer(orbis.nodes$size.rank)
orbis.nodes$is.port = ifelse(orbis.nodes$is.port == 't', TRUE, FALSE)

# these are nodes that appear in the orbis.edges data loaded below but which are not available in the API
orbis.nodes <- rbind(orbis.nodes,c(50038,"x",36.039,34.534,"","",F,6))
orbis.nodes <- rbind(orbis.nodes,c(50317,"Portus",41.78,12.258,"","",T,8))
orbis.nodes <- rbind(orbis.nodes,c(50457,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50522,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50572,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50721,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50726,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50727,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50730,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50731,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50732,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50733,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50735,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50736,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50737,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50738,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50739,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50745,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50746,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50747,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50748,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50749,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50750,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50751,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50752,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50753,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50754,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50757,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50760,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50763,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50764,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50765,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50766,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50767,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50768,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50769,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50770,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50771,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50772,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50773,"",0,0,"","",FALSE,0))
orbis.nodes <- rbind(orbis.nodes,c(50774,"",0,0,"","",FALSE,0))


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

