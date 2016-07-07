#!/bin/bash
thisdir=$(pwd)
WORKSPACE=$thisdir/../..
TARGET=$thisdir/install
BUILD_TARGET=$thisdir/build

echo "Cleaning previous build ..."
make -f Makefile.bmv2 full-clean

echo "Installing PTF ..."
SUBMODULE=$WORKSPACE/ptf
mkdir -p $BUILD_TARGET/ptf
cd $SUBMODULE
python setup.py build -b $BUILD_TARGET/ptf install --prefix $TARGET --single-version-externally-managed --record install_files.txt


echo "Installing BMv2 Model ..."
SUBMODULE=$WORKSPACE/p4-bmv2
cd $SUBMODULE
./autogen.sh
mkdir -p $BUILD_TARGET/p4-bmv2
cd $BUILD_TARGET/p4-bmv2
$SUBMODULE/configure --with-pdfixed --prefix=$TARGET
make -j8
make install

echo "Installing p4c-bmv2 ..."
SUBMODULE=$WORKSPACE/p4c-bmv2
mkdir -p $BUILD_TARGET/p4c-bmv2
cd $SUBMODULE
python setup.py build -b $BUILD_TARGET/p4c-bmv2 install --prefix $TARGET --single-version-externally-managed --record install_files.txt

echo "Compiling Switch ..."
SUBMODULE=$WORKSPACE/switch
cd $SUBMODULE
git submodule update --init --recursive
./autogen.sh
mkdir -p $BUILD_TARGET/switch
cd $BUILD_TARGET/switch
$SUBMODULE/configure --with-bmv2 --with-switchsai --enable-thrift --prefix=$TARGET
make
