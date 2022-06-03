#!/bin/sh

# garmin-connect-export full sync wrapper
#
# Usage: gcexport-sync.sh EXPORT_DIR [GCEXPORT_DIR_PATH] [BRANCH_NAME]
#
# Params:
# - EXPORT_DIR -- target directory for exported activities
# - GCEXPORT_DIR_PATH -- gcexport.py location (optional)
# - BRANCH_NAME -- execution branch name (optional)

if [ -z $1 ]; then
	echo "Usage: gcexport-sync.sh EXPORT_DIR [GCEXPORT_DIR_PATH] [BRANCH_NAME]" >&2
	exit 1
fi

TARGET=$1
APP_PATH=${2:-`pwd`}
BRANCH=$3

pushd . > /dev/null
cd $APP_PATH

if [ ! -z $BRANCH ]; then
	git switch $BRANCH
fi

if [ $? -eq 0 ]; then
	./gcexport-bw.sh \
		--directory $TARGET \
		--count all \
		--format original \
		--unzip \
		--originaltime \
		--fileprefix \
		--desc
fi

popd > /dev/null
