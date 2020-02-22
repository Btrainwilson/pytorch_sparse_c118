#!/bin/bash

METIS=metis-5.1.0

wget -nv http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/${METIS}.tar.gz
tar -xvzf ${METIS}.tar.gz
cd ${METIS} || exit
sed -i.bak -e 's/IDXTYPEWIDTH 32/IDXTYPEWIDTH 64/g' include/metis.h

if [ "${TRAVIS_OS_NAME}" != "windows" ]; then
  make config
  make
else
  ./vsgen.bat
  echo "--- BUILD"
  ls build
  echo "--- WINDOWS"
  ls build/windows
  echo "--- LIBMETIS"
  ls build/windows/libmetis
  echo "--- RELEASE"
  ls build/windows/libmetis/Release
fi

sudo make install

cd ..
