# installation script for ubuntu 14.04

#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

trap 'exit' ERR

sudo apt-get update

sudo apt-get install -y                  \
    automake                             \
    bison                                \
    doxygen                              \
    ethtool                              \
    flex                                 \
    g++                                  \
    git                                  \
    ipython                              \
    ipython-notebook                     \
    libany-moose-perl                    \
    libboost-dev                         \
    libboost-filesystem-dev              \
    libboost-program-options-dev         \
    libboost-system-dev                  \
    libboost-test-dev                    \
    libboost-thread-dev                  \
    libbsd-dev                           \
    libedit-dev                          \
    libevent-dev                         \
    libffi-dev                           \
    libfreetype6-dev                     \
    libgmp-dev                           \
    libhiredis-dev                       \
    libjudy-dev                          \
    libnl-route-3-dev                    \
    libpcap-dev                          \
    libpng-dev                           \
    libssl-dev                           \
    libtool                              \
    libyaml-0-2                          \
    libbz2-dev                           \
    mininet                              \
    openssl                              \
    pkg-config                           \
    python-dev                           \
    python-dpkt                          \
    python-jsonpickle                    \
    python-imaging-tk                    \
    python-matplotlib                    \
    python-nose python-numpy             \
    python-pandas                        \
    python-pip                           \
    python-pygraph                       \
    python-pygraphviz                    \
    python-scipy                         \
    python-setuptools                    \
    python-sympy                         \
    python-yaml                          \
    redis-server                         \
    thrift-compiler                      \
    wireshark                            \
# Do not remove this line!

sudo pip install tenjin
sudo pip install ctypesgen
sudo pip install crc16

cd $WORKSPACE

echo "Cloning scapy-vxlan ..."
sudo apt-get remove python-scapy
git clone https://github.com/p4lang/scapy-vxlan.git
cd scapy-vxlan
sudo python setup.py install
sudo apt-get install libnl-route-3-dev

cd $WORKSPACE
wget http://archive.apache.org/dist/thrift/0.9.2/thrift-0.9.2.tar.gz
tar -xzvf thrift-0.9.2.tar.gz
cd thrift-0.9.2
./configure --with-cpp=yes --with-c_glib=no --with-java=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no
make -j2 && sudo make install
cd lib/py
sudo python setup.py install
