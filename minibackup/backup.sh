#!/bin/bash

# no automatic install, to install:
# sudo ln -s /path/to/scriptthings/minibackup/backup.sh /usr/local/bin/backup

if [ -L ${0} ]; then
    scriptpath=`readlink ${0}`
else
    scriptpath=${0}
fi

basepath=`dirname ${scriptpath}`
test -f ${basepath}/backup.cfg || ( echo "Config not found" && exit 1 )

opts=""
# any arg == verbose
if [ "${1}" != "" ]; then
    opts="-v"
fi

 . ${basepath}/backup.cfg

echo -n "Backup started " &&
echo `date`;

sudo chown -R ${USER} ${src}

for d in ${dirs}; do
    mkdir -p ${src}/${d}
    rsync -rutgplo ${opts} ${src}/${d}/ ${dst}/${d}/;
done

echo -n "Backup finished " &&
echo `date`;

