#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

cd $WORKSPACE

echo "Cloning scapy-vxlan ..."
sudo apt-get remove python-scapy
git clone https://github.com/p4lang/scapy-vxlan.git
cd scapy-vxlan
sudo python setup.py install

sudo pip install tenjin
sudo pip install ctypesgen
sudo pip install crc16

