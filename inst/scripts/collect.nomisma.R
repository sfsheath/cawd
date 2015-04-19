# first go at script to load nomisma.org data into cawd.
library(devtools)
library(sp)
library(SPARQL)

url <- "http://nomisma.org/query"

ns = c('geo','<http://www.w3.org/2003/01/geo/wgs84_pos#>',
      'nmo','<http://nomisma.org/ontology#>',
      'pleiades','<http://pleiades.stoa.org/places/',
      'skos','<http://www.w3.org/2004/02/skos/core#>',
      'spatial','<http://jena.apache.org/spatial#>',
      'xsd','<http://www.w3.org/2001/XMLSchema#>')


# greek  (turn parts of these chunks into functions)
sparql.response <- SPARQL(url = url, ns = ns,
                       query = '
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX dcterms:	<http://purl.org/dc/terms/>
PREFIX geo:	<http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX nm:	<http://nomisma.org/id/>
PREFIX nmo:	<http://nomisma.org/ontology#>
PREFIX skos:	<http://www.w3.org/2004/02/skos/core#>
PREFIX spatial: <http://jena.apache.org/spatial#>
PREFIX xsd:	<http://www.w3.org/2001/XMLSchema#>
SELECT  ?title ?uri ?latitude ?longitude ?pleiades WHERE {
 ?uri a nmo:Mint;
 dcterms:isPartOf nm:greek_numismatics ;
 skos:prefLabel ?title;
 geo:location ?loc .
 OPTIONAL {?uri skos:relatedMatch ?pleiades}
 ?loc geo:lat ?latitude ;
 geo:long ?longitude  .
 FILTER (langMatches(lang(?title), "en") && regex(str(?pleiades), "pleiades.stoa.org" ))
}'
)

nomisma.greek.mints <- sparql.response$results

# remove host and path from Pleiades ID
nomisma.greek.mints$pleiades <- sub('pleiades:/','',nomisma.greek.mints$pleiades, fixed = T)

nomisma.greek.mints$title <- gsub('"','',nomisma.greek.mints$title, fixed = T)
nomisma.greek.mints$title <- gsub('@en','',nomisma.greek.mints$title, fixed = T)

nomisma.greek.mints$uri <- gsub('<','',nomisma.greek.mints$uri, fixed = T)
nomisma.greek.mints$uri <- gsub('>','',nomisma.greek.mints$uri, fixed = T)


nomisma.greek.mints.sp <- nomisma.greek.mints
coordinates(nomisma.greek.mints.sp) <- ~ longitude + latitude
proj4string(nomisma.greek.mints.sp) <- CRS("+proj=longlat +datum=WGS84")

use_data(nomisma.greek.mints, overwrite = T)
use_data(nomisma.greek.mints.sp, overwrite = T)

# roman
sparql.response <- SPARQL(url = url, ns = ns,
                          query = '
                          PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                          PREFIX dcterms:  <http://purl.org/dc/terms/>
                          PREFIX geo:	<http://www.w3.org/2003/01/geo/wgs84_pos#>
                          PREFIX nm:	<http://nomisma.org/id/>
                          PREFIX nmo:	<http://nomisma.org/ontology#>
                          PREFIX skos:	<http://www.w3.org/2004/02/skos/core#>
                          PREFIX spatial: <http://jena.apache.org/spatial#>
                          PREFIX xsd:	<http://www.w3.org/2001/XMLSchema#>
                          SELECT  ?title ?uri ?latitude ?longitude ?pleiades WHERE {
                          ?uri a nmo:Mint;
                          dcterms:isPartOf nm:roman_numismatics ;
                          skos:prefLabel ?title;
                          geo:location ?loc .
                          OPTIONAL {?uri skos:relatedMatch ?pleiades}
                          ?loc geo:lat ?latitude ;
                          geo:long ?longitude  .
                          FILTER (langMatches(lang(?title), "en") && regex(str(?pleiades), "pleiades.stoa.org" ))
                          }'
)

nomisma.roman.mints <- sparql.response$results

# remove host and path from Pleiades ID
nomisma.roman.mints$pleiades <- sub('pleiades:/','',nomisma.roman.mints$pleiades, fixed = T)

nomisma.roman.mints$title <- gsub('"','',nomisma.roman.mints$title, fixed = T)
nomisma.roman.mints$title <- gsub('@en','',nomisma.roman.mints$title, fixed = T)

nomisma.roman.mints$uri <- gsub('<','',nomisma.roman.mints$uri, fixed = T)
nomisma.roman.mints$uri <- gsub('>','',nomisma.roman.mints$uri, fixed = T)

nomisma.roman.mints.sp <- nomisma.roman.mints
coordinates(nomisma.roman.mints.sp) <- ~ longitude + latitude
proj4string(nomisma.roman.mints.sp) <- CRS("+proj=longlat +datum=WGS84")

use_data(nomisma.roman.mints, overwrite = T)
use_data(nomisma.roman.mints.sp, overwrite = T)

# roman provincial. the nomisma data is clearly incomplete as only 4 mints are listed. needs work on that end.
sparql.response <- SPARQL(url = url, ns = ns,
                          query = '
                          PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                          PREFIX dcterms:  <http://purl.org/dc/terms/>
                          PREFIX geo:	<http://www.w3.org/2003/01/geo/wgs84_pos#>
                          PREFIX nm:	<http://nomisma.org/id/>
                          PREFIX nmo:	<http://nomisma.org/ontology#>
                          PREFIX skos:	<http://www.w3.org/2004/02/skos/core#>
                          PREFIX spatial: <http://jena.apache.org/spatial#>
                          PREFIX xsd:	<http://www.w3.org/2001/XMLSchema#>
                          SELECT  ?title ?uri ?latitude ?longitude ?pleiades WHERE {
                          ?uri a nmo:Mint;
                          dcterms:isPartOf nm:roman_provincial_numismatics ;
                          skos:prefLabel ?title;
                          geo:location ?loc .
                          OPTIONAL {?uri skos:relatedMatch ?pleiades}
                          ?loc geo:lat ?latitude ;
                          geo:long ?longitude  .
                          FILTER (langMatches(lang(?title), "en") && regex(str(?pleiades), "pleiades.stoa.org" ))
                          }'
)

nomisma.roman.provincial.mints <- sparql.response$results

# remove host and path from Pleiades ID
nomisma.roman.provincial.mints$pleiades <- sub('pleiades:/','',nomisma.roman.provincial.mints$pleiades, fixed = T)

nomisma.roman.provincial.mints$title <- gsub('"','',nomisma.roman.provincial.mints$title, fixed = T)
nomisma.roman.provincial.mints$title <- gsub('@en','',nomisma.roman.provincial.mints$title, fixed = T)

nomisma.roman.provincial.mints$uri <- gsub('<','',nomisma.roman.provincial.mints$uri, fixed = T)
nomisma.roman.provincial.mints$uri <- gsub('>','',nomisma.roman.provincial.mints$uri, fixed = T)


nomisma.roman.provincial.mints.sp <- nomisma.roman.provincial.mints
coordinates(nomisma.roman.provincial.mints.sp) <- ~ longitude + latitude
proj4string(nomisma.roman.provincial.mints.sp) <- CRS("+proj=longlat +datum=WGS84")

use_data(nomisma.roman.provincial.mints, overwrite = T)
use_data(nomisma.roman.provincial.mints.sp, overwrite = T)
