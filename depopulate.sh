echo "Remove model & form specification"
GRAPH=model:form.ttl
echo "DROP GRAPH <$GRAPH>" > /tmp/delete_graph.rq
sbt <<EOF
runMain tdb.tdbupdate --loc=TDB --verbose --update=/tmp/delete_graph.rq
EOF

GRAPH=model:modele.owl.ttl
echo "DROP GRAPH <$GRAPH>" > /tmp/delete_graph.rq
sbt <<EOF
runMain tdb.tdbupdate --loc=TDB --verbose --update=/tmp/delete_graph.rq
EOF

