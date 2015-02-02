#!/bin/bash

## Copyright 2015 DevOpsGuys
## Licensed under the MIT license
## Pull Requests Accepted :)

RH_VER=$(cat /etc/redhat-release | cut -d " " -f 3 | cut -d "." -f 1 )
if [ "$RH_VER" ==  "5" ]; then
  GOOD_VER="glibc-2.5-123.el5_11.1"
fi
if [ "$RH_VER" ==  "6" ] || [ "$RH_VER" == "7" ]; then
  GOOD_VER="glibc-2.12-1.149.el6_6.5"
fi
CURRENT_VERSION=$(rpm -qa | grep glibc-2 | cut -d "." -f -5)
if [ "$CURRENT_VERSION" != "$GOOD_VER" ]; then
   echo "CURRENT VERSION IS $CURRENT_VERSION - SHOULD BE $GOOD_VER"
   exit 2
else
   echo "CURRENT VERSION ( $CURRENT_VERSION ) IS OK"
   exit 0
fi
