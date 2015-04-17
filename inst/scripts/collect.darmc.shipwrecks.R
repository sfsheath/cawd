library(devtools)
library(maptools)
library(rgdal)
library(sp)

# assumes excel spreadsheet has been download and exported to csv. change file names as necessary
read.csv("~/Documents/darmc//darmc.shipwrecks.csv") -> darmc.shipwrecks

darmc.shipwrecks <- darmc.shipwrecks[1:28] # drop any extra columns

names(darmc.shipwrecks) <- c("title",
                                        "title.other",
                                        "X2008.Wreck.ID",
                                        "latitude",
                                        "longitude",
                                        "Geo.Q",
                                        "start.date",
                                        "end.date",
                                        "Date.Q",
                                        "Depth",
                                        "Depth.Q",
                                        "Year.Found",
                                        "Year.Found.Q",
                                        "Cargo.1",
                                        "Type.1",
                                        "Cargo.2",
                                        "Type.2",
                                        "Cargo.3",
                                        "Type.3",
                                        "Other.Cargo",
                                        "Gear",
                                        "Estimated.Capacity",
                                        "comment",
                                        "Length",
                                        "Width",
                                        "Size.Estimate.Q",
                                        "Parker.reference",
                                        "Bibliography.and.Notes"
                                        )

darmc.shipwrecks.sp <- darmc.shipwrecks[complete.cases(darmc.shipwrecks[4:5]),]

coordinates(darmc.shipwrecks.sp) <- ~ longitude + latitude
proj4string(darmc.shipwrecks.sp) <- CRS("+proj=longlat +datum=WGS84")

use_data(darmc.shipwrecks, overwrite = T)
use_data(darmc.shipwrecks.sp, overwrite = T)
