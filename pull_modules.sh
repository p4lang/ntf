#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

cd $WORKSPACE

echo "Cloning ptf ..."
git clone https://github.com/p4lang/ptf.git

echo "Cloning p4-bmv2 ..."
git clone https://github.com/p4lang/behavioral-model.git p4-bmv2

echo "Cloning p4c-bmv2 ..."
git clone https://github.com/p4lang/p4c-bm.git p4c-bmv2

echo "Cloning p4-hlir"
git clone https://github.com/p4lang/p4-hlir.git

echo "Cloning switch ..."
git clone https://github.com/barefootnetworks/switch-int-demo.git switch
cd $WORKSPACE/switch
git checkout int_geneve_demo
