#!/bin/bash

if [ -z "${MIRROR_DIR}" ]; then
	echo MIRROR_DIR is not set.
	exit 1
fi

debmirror -a amd64 \
    --no-source \
    -s main,restricted,universe,multiverse \
    -h ppa.launchpad.net \
    -d focal \
    -r /ansible/ansible/ubuntu \
    --progress \
    --method=http \
    --rsync-extra=none \
    ${MIRROR_DIR}
