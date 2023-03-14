#!/bin/bash

python_ver=$(find /usr/local/lib -maxdepth 1 -type d -name python3.\* -printf '%P\n' | sort -V | head -n 1)

cd /usr/local/lib/"${python_ver}"/site-packages || exit
wget https://gist.githubusercontent.com/ookiineko/9099b4c13bf56ddf0724fceea0c0cc91/raw/0c843c58632034e2edb992ee6266a5840e9799e5/0001-building-utils-don-t-check-verinfo-and-manifests-on-.patch \
     -O cygwin.patch
dos2unix PyInstaller/building/utils.py
patch -p1 < cygwin.patch
rm -f cygwin.patch
