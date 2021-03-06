#!/bin/bash

set -e

if [ $# -lt 4 ]; then
    echo "Usage: $0 $# <dummy_port> <altID> <usbID> <binfile>" >&2
    exit 1
fi
dummy_port=$1; altID=$2; usbID=$3; binfile=$4;dummy_port_fullpath="/dev/$1"

#if we can find the Serial device try resetting it and then sleeping for 1 sec while the board reboots

if [ -e $dummy_port_fullpath ]; then
	echo "resetting " $dummy_port_fullpath
	echo “1EAF” > $dummy_port_fullpath
	sleep 2
fi


DFU_UTIL=$(dirname $0)/dfu-util/dfu-util
if [ ! -x ${DFU_UTIL} ]; then
    echo "$0: error: cannot find ${DFU_UTIL}" >&2
    exit 2
fi

${DFU_UTIL} -d ${usbID} -a ${altID} -s 0x08000000:leave -D ${binfile}
