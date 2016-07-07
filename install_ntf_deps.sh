# installation script for ubuntu 14.04

#!/bin/bash
thisdir=$(pwd)
WORKSPACE="$(dirname "$thisdir")"

trap 'exit' ERR

sudo apt-get update

cd $WORKSPACE/p4-bmv2
echo "Installing p4-bmv2 dependencies"
./install_deps.sh

cd $WORKSPACE/p4c-bmv2
echo "Installing p4c-bmv2 dependencies"
sudo pip install -r requirements.txt

sudo apt-get install -y                  \
    doxygen                              \
    ethtool                              \
    git                                  \
    ipython                              \
    ipython-notebook                     \
    libany-moose-perl                    \
    libbsd-dev                           \
    libedit-dev                          \
    libfreetype6-dev                     \
    libhiredis-dev                       \
    libnl-route-3-dev                    \
    libpng-dev                           \
    libyaml-0-2                          \
    libbz2-dev                           \
    openssl                              \
    python-dpkt                          \
    python-jsonpickle                    \
    python-imaging-tk                    \
    python-matplotlib                    \
    python-nose python-numpy             \
    python-pandas                        \
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

sudo pip install ctypesgen
sudo pip install crc16

cd $WORKSPACE
wget http://archive.apache.org/dist/thrift/0.9.2/thrift-0.9.2.tar.gz
tar -xzvf thrift-0.9.2.tar.gz
cd thrift-0.9.2
./configure --with-cpp=yes --with-c_glib=no --with-java=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no
make -j2 && sudo make install
cd lib/py
sudo python setup.py install
