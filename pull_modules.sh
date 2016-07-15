#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

cd $WORKSPACE

echo "Cloning ptf ..."
git clone https://github.com/p4lang/ptf.git
cd $WORKSPACE/ptf
git checkout b17f9d2ce75dbee5912127230f9fc909b13d90a5

cd $WORKSPACE
echo "Cloning p4-bmv2 ..."
git clone https://github.com/p4lang/behavioral-model.git p4-bmv2
cd $WORKSPACE/p4-bmv2
git checkout 8107e1a416de32eedea275d648e75b74b3006539

cd $WORKSPACE
echo "Cloning p4c-bmv2 ..."
git clone https://github.com/p4lang/p4c-bm.git p4c-bmv2
cd $WORKSPACE/p4c-bmv2
git checkout 2cbf8c40dd1d5badd901427ebae1807616650c40

cd $WORKSPACE
echo "Cloning p4-hlir"
git clone https://github.com/p4lang/p4-hlir.git

cd $WORKSPACE
echo "Cloning switch ..."
git clone git@github.com:barefootnetworks/switch-int-demo.git switch
cd $WORKSPACE/switch
git checkout int_geneve_demo

cd $WORKSPACE
echo "Cloning scapy-vxlan ..."
sudo apt-get remove python-scapy
git clone https://github.com/p4lang/scapy-vxlan.git
cd scapy-vxlan
git checkout a63c60e4dd1cf4d4dbc847d3938526a60843363c
sudo python setup.py install
