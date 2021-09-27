#!/bin/bash

if [ -z "${MIRROR_DIR}" ]; then
	echo MIRROR_DIR is not set.
	exit 1
fi

debmirror -a amd64 \
	--no-source \
	-s main \
	-h faculty.math.illinois.edu \
	-d bionic,focal \
	-r /Macaulay2/Repositories/Ubuntu \
	--progress \
	--method=https \
	--rsync-extra=none \
	${MIRROR_DIR}
