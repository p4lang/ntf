#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

cd $WORKSPACE

echo "Updating ptf-tests ..."
cd $WORKSPACE/ptf
git pull

echo "Updating p4-bmv2 ..."
cd $WORKSPACE/p4-bmv2
git pull

echo "Updating p4c-bmv2 ..."
cd $WORKSPACE/p4c-bmv2
git pull

echo "Updating switch ..."
cd $WORKSPACE/switch
git pull

echo "Updating scapy-vxlan ..."
cd $WORKSPACE/scapy-vxlan
git pull
sudo python setup.py install
