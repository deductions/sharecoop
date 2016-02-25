#!/bin/bash

echo maybe "cd ~/src/semantic_forms/scala/forms ; git pull --verbose ; sbt publishLocal" before ?
echo
SRC=$HOME/src/sharecoop
APP=sharecoop
APPVERS=${APP}-1.0-SNAPSHOT
DEPLOYDIR=SHAREDCOOP
SBT=sbt
echo "$DEPLOYDIR update Play! server when code has changed"

cd $SRC
git pull --verbose
$SBT dist
echo "sofware recompiled!"

cd ~/deploy
kill `cat ${APPVERS}/RUNNING_PID`

# pour garder les logs
rm -r ${APPVERS}_OLD
mv ${APPVERS} ${APPVERS}_OLD

unzip $SRC/target/universal/${APPVERS}.zip

mv ${APPVERS} $DEPLOYDIR
cd ${DEPLOYDIR}
ln -s ../TDBsc TDB
ln -s ../TDB2sc TDB2
nohup bin/${APP} -mem 100 -J-server -Dhttp.port=9333 &
