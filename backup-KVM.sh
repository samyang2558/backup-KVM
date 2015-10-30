#!/bin/sh
## Setting target DOMAIN and output directory ##
DOMAIN=cent70-0302-33-03-3DAVA
OUTPUTDIR=/tmp/virsh-backup_files
if [ ! -e ${OUTPUTDIR} ]; then
  mkdir -p ${OUTPUTDIR}
fi
DATE=`date +%Y%m%d%H%M`
FILENAME=${DOMAIN}_${DATE}
LOGFILESUM=`ls -1 ${OUTPUTDIR} | wc -l`
OLDESTFILE=`ls -1 ${OUTPUTDIR} | head -1`

## backup DOMAIN ##
virsh save ${DOMAIN} ${OUTPUTDIR}/${FILENAME}.img
## Start DOMAIN ##
virsh start ${DOMAIN}

if test ${LOGFILESUM} -ge 7;then
  rm ${OUTPUTDIR}/${OLDESTFILE}
fi
