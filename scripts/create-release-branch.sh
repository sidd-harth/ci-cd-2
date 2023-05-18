#!/bin/bash
echo "============================================================"
echo "DEBUG - Fetching Major Minor Version for Release Branch Name"
echo "------------------------------------------------------------"

POM_VERSION=$(mvn help:evaluate -Dexpression='project.version' -q -DforceStdout);

echo "DEBUG - POM_VERSION: $POM_VERSION"

MAJOR_VERSION=$(echo $POM_VERSION | cut -d. -f1)
MINOR_VERSION=$(echo $POM_VERSION | cut -d. -f2)
PATCH_VERSION=$(echo $POM_VERSION | cut -d. -f3 | cut -d- -f1)
MAVEN_QUALIFIER=$(echo $POM_VERSION | cut -d- -f2)
VERSION_WITHOUT_BUILD_NUMBER=$(echo $POM_VERSION | sed 's/^\(.*-\)\([0-9]*\)$/\1/')
VERSION_BUILD_NUMBER=$(echo $POM_VERSION | sed 's/^\(.*-\)\([0-9]*\)$/\2/')

echo "DEBUG - MAJOR_VERSION: $MAJOR_VERSION"
echo "DEBUG - MINOR_VERSION: $MINOR_VERSION"
echo "DEBUG - PATCH_VERSION: $PATCH_VERSION"
echo "DEBUG - MAVEN_QUALIFIER: $MAVEN_QUALIFIER"
echo "VERSION_WITHOUT_BUILD_NUMBER: ${VERSION_WITHOUT_BUILD_NUMBER}"
echo "VERSION_BUILD_NUMBER: ${VERSION_BUILD_NUMBER}"

echo "------------------------------------------------------------"
echo "DEBUG - Create Release Branch"
echo "------------------------------------------------------------"

if [ ${JOB_NAME} -eq 'bugfix-release' ]
then
    git checkout -b release/$MAJOR_VERSION.$MINOR_VERSION-${env.VERSION_BUILD_NUMBER} release/$MAJOR_VERSION.$MINOR_VERSION;
else
    git checkout develop;
    git checkout -b release/$MAJOR_VERSION.$MINOR_VERSION develop;
fi

echo "============================================================"

