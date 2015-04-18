# first go at script to load nomisma.org data into cawd.
library(devtools)
library(sp)
library(SPARQL)

sparql.response <- SPARQL(url = "http://nomisma.org/query",
                       query = 'PREFIX dcterms:  <http://purl.org/dc/terms/>
                       PREFIX geo:	<http://www.w3.org/2003/01/geo/wgs84_pos#>
                       PREFIX nm:	<http://nomisma.org/id/>
                       PREFIX nmo:	<http://nomisma.org/ontology#>
                       PREFIX skos:	<http://www.w3.org/2004/02/skos/core#>
                       PREFIX spatial: <http://jena.apache.org/spatial#>
                       PREFIX xsd:	<http://www.w3.org/2001/XMLSchema#>
                       SELECT  ?title ?uri ?latitude ?longitude WHERE {
                       ?uri a nmo:Mint;
                       dcterms:isPartOf nm:greek_numismatics ;
                       skos:prefLabel ?title;
                       geo:location ?loc .
                       ?loc geo:lat ?latitude ;
                       geo:long ?longitude  .
                       FILTER langMatches (lang(?title), "en")
                       }'
                       )

nomisma.greek.mints <- sparql.response$results

nomisma.greek.mints.sp <- nomisma.greek.mints
coordinates(nomisma.greek.mints.sp) <- ~ longitude + latitude
proj4string(nomisma.greek.mints.sp) <- CRS("+proj=longlat +datum=WGS84")

use_data(nomisma.greek.mints, overwrite = T)
use_data(nomisma.greek.mints.sp, overwrite = T)
