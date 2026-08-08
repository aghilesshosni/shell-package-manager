#!/bin/bash

if ! command -v dpkg-query &> /dev/bull ;then
   echo "[ERROR] dpkg-query is not installed, are you on a Debian Based distribution ?"
   exit 1
fi
