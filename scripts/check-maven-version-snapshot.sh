#!/bin/bash
echo "=================================================="
echo "DEBUG - Reading POM file to obtain current version"
echo "--------------------------------------------------"

POM_SNAPSHOT_VERSION=$(mvn help:evaluate -Dexpression='project.version' -q -DforceStdout);
echo "DEBUG - Artifact version: $POM_SNAPSHOT_VERSION"

echo POM_MAJOR_VERSION=$(mvn help:evaluate -Dexpression='project.version' -q -DforceStdout |  cut -d. -f1 ); >> build-${env.BUILD_NUMBER}-pom-version.properties
echo POM_MINOR_VERSION=$(mvn help:evaluate -Dexpression='project.version' -q -DforceStdout |  cut -d. -f2 ); >> build-${env.BUILD_NUMBER}-pom-version.properties
echo POM_PATCH_VERSION=$(mvn help:evaluate -Dexpression='project.version' -q -DforceStdout |  cut -d. -f3 | cut -d- -f1 ); >> build-${env.BUILD_NUMBER}-pom-version.properties

if [[ $POM_SNAPSHOT_VERSION == *"-SNAPSHOT"* ]];
then
 echo "DEBUG - It's an Snapshot version"
 echo "=================================================="
else
 echo "DEBUG - Version is NOT an Snapshot"
 echo "ERROR - Script failed and will exit"
 echo "=================================================="
 exit -1
fi
