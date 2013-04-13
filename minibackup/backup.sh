#!/bin/bash

test -f backup.cfg || ( echo "Config not found" && exit 1 )

 . backup.cfg

echo -n "Backup started " &&
echo `date`;

for d in ${dirs}; do
    rsync -rvutgplo ${src}/${d}/ ${dst}/${d}/;
done

echo -n "Backup finished " &&
echo `date`;

