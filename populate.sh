#!/bin/bash

function graphload {
URI=$1
GRAPH=$2
MESS="l'URI $URI dans le graphe $GRAPH dans la base TDB."
echo "Charger $MESS"
echo "LOAD <$URI> INTO GRAPH <$GRAPH>" > /tmp/load_graph.rq
sbt <<EOF
runMain tdb.tdbupdate --loc=TDB --verbose --update=/tmp/load_graph.rq
EOF
echo "Local SPARQL database in TDB/ : chargé $MESS."
}

wget http://rdf.insee.fr/geo/cog-2014.ttl.zip
unzip cog-2014.ttl.zip

graphload $PWD/model/form.ttl model:form.ttl
graphload $PWD/model/modele.owl.ttl model:modele.owl.ttl
export SBT_OPTS="-Xmx2G"
graphload $PWD/cog-2014.ttl data:/cog-2014

