#!/bin/bash
#Here we install a global version of RDKit in order to make it work with the database cartridge
export RDBASE=$HOME/rdkit
export LD_LIBRARY_PATH=$RDBASE/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$RDBASE:$PYTHONPATH

cd $HOME
git clone https://github.com/rdkit/rdkit
cd rdkit/
git checkout tags/Release_2014_03_1
cd $RDBASE/External/INCHI-API
sed -i 's/sites\/default\/files\/inchi-1.04\/INCHI-1-API\.ZIP/wp\/wp-content\/uploads\/2014\/06\/INCHI-1-API\.zip/g' download-inchi.sh
bash download-inchi.sh

cd $RDBASE
mkdir build
cd build
cmake -DRDK_BUILD_INCHI_SUPPORT=ON -DBoost_USE_STATIC_LIBS=OFF ..
make -j4 install
ctest

cd $RDBASE/Code/PgSQL/rdkit
make
echo "chemblvm" | sudo -S make install
make installcheck
