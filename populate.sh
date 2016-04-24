#!/bin/bash

function graphload {
  URI=$1
  GRAPH=$2
  MESS="l'URI $URI dans le graphe $GRAPH dans la base TDB."
  echo "Charger $MESS"
  echo "LOAD <$URI> INTO GRAPH <$GRAPH>" > /tmp/load_graph.rq
  echo "DROP GRAPH <$GRAPH>" > /tmp/drop_graph.rq
  cd $SERVER_DIR
    sbt <<EOF
    runMain tdb.tdbupdate --loc=TDB --verbose --update=/tmp/drop_graph.rq
    runMain tdb.tdbupdate --loc=TDB --verbose --update=/tmp/load_graph.rq
EOF
    echo "Local SPARQL database in TDB/ : chargé $MESS."
  cd $DATA_DIR
}

DATA_DIR=$PWD
SERVER_DIR=../semantic_forms-sharecop/scala/forms_play

wget http://rdf.insee.fr/geo/cog-2014.ttl.zip
unzip cog-2014.ttl.zip

graphload $PWD/model/form.ttl		model:form.ttl
graphload $PWD/model/modele.owl.ttl	model:modele.owl.ttl
graphload $PWD/model/form_cs.ttl	model:form_cs.ttl
graphload $PWD/model/modele_cs.owl.ttl	model:modele_cs.owl.ttl

export SBT_OPTS="-Xmx1G"
graphload $PWD/cog-2014.ttl data:/cog-2014

