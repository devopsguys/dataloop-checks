#!/bin/bash

DEB_OR_UBU=$(lsb_release -ds | cut -d " " -f 1)
INSTALLED_VERSION=$(dpkg -s openssl | grep Version | awk '{ print $2 }')
FIXED_VERSION=""
if [ "$DEB_OR_UBU" == "Ubuntu" ]; then
  UBUNTU_RELEASE=$(lsb_release -sr | cut -d '.' -f 1)
  case $UBUNTU_RELEASE in
    10)
      FIXED_VERSION=0.9.8k-7ubuntu8.27 ;;
    12)
      FIXED_VERSION=1.0.1-4ubuntu5.25 ;;
    14)
      FIXED_VERSION=1.0.1f-1ubuntu2.11 ;;
  esac
else
  DEBIAN_RELEASE=$(lsb_release -sr | cut -c 1)
  case $DEBIAN_RELEASE in
    6)
      FIXED_VERSION=0.9.8o-4squeeze20 ;; # Security only
    7)
      FIXED_VERSION=1.0.1e-2+deb7u15 ;; # Security only
    8)
      FIXED_VERSION=1.0.1k-2 ;; # sid only
  esac
fi

dpkg --compare-versions $INSTALLED_VERSION ge $FIXED_VERSION
if [ ! $? -eq 0 ] ; then
  echo Installed is $INSTALLED_VERSION, should be $FIXED_VERSION
  exit 2
else
  echo Installed is $INSTALLED_VERSION, looks OK.
  exit 0
fi 
