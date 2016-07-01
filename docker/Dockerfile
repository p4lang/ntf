FROM      ubuntu:14.04
MAINTAINER Antonin Bas <antonin@barefootnetworks.com>

RUN apt-get update
RUN apt-get install -y \
    automake \
    autopoint \
    bison \
    bridge-utils \
    build-essential \
    cmake \
    ethtool \
    flex \
    g++ \
    gdb \
    git \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libedit-dev \
    libev-dev \
    libevent-dev \
    libffi-dev \
    libglib2.0-dev \
    libgmp-dev \
    libhiredis-dev \
    libjson0 \
    libjson0-dev \
    libjudy-dev \
    libnl-route-3-dev \
    libpcap0.8 \
    libpcap0.8-dev \
    libpcap-dev \
    libtool \
    libssl-dev \
    mktemp \
    openssh-server \
    packit \
    pkg-config \
    python-dev \
    python-pip \
    python-pygraph \
    python-pygraphviz \
    python-setuptools \
    python-texttable \
    python-thrift \
    python-yaml \
    quagga \
    redis-server \
    redis-tools \
    subversion \
    texinfo \
    tshark \
    valgrind \
    vim \
    xterm

RUN pip install crc16

# install libuio
RUN mkdir -p /tmp/libuio ; \
    cd /tmp/libuio ; \
    git clone https://github.com/Linutronix/libuio ; \
    cd libuio ; \
    ./autogen.sh ; ./configure ; make install ; ldconfig ; \
    rm -fr /tmp/libuio

# install cjson
RUN mkdir -p /tmp/cjson ; \
    cd /tmp/cjson ; \
    git clone https://@github.com/kbranigan/cJSON.git ; \
    cd cJSON ; \
    make ; make install ; ldconfig ; \
    rm -fr /tmp/cjson

# install scapy
RUN mkdir -p /tmp/scapy ; \
    cd /tmp/scapy ; \
    git clone https://github.com/p4lang/scapy-vxlan.git ; \
    cd scapy-vxlan ; \
    python setup.py install ; \
    rm -fr /tmp/scapy

RUN mkdir -p /tmp/libcrafter; \
    cd /tmp/; \
    git clone https://github.com/pellegre/libcrafter ; \
    cd /tmp/libcrafter/libcrafter ; \
    ./autogen.sh ;  \
    make -j 4 ; \
    make install ; \
    ldconfig ; \
    rm -fr /tmp/libcrafter

RUN mkdir -p /tmp/libcli; \
    cd /tmp/; \
	git clone https://github.com/dparrish/libcli.git; \
    cd /tmp/libcli/ ; \
    make -j 4 ; \
    make install ; \
    ldconfig ; \
    rm -fr /tmp/libcli

# install ctypesgen
RUN mkdir -p /tmp/ctypesgen ; \
    cd /tmp/ctypesgen ; \
    git clone https://github.com/davidjamesca/ctypesgen.git ; \
    cd ctypesgen ; \
    python setup.py install ; \
    rm -fr /tmp/ctypesgen

# install mstpd
RUN mkdir -p /third-party/diffs
COPY diffs/mstpd.diff /third-party/diffs/mstpd.diff
RUN cd /third-party; \
    svn checkout svn://svn.code.sf.net/p/mstpd/code/trunk mstpd; \
    cd mstpd; patch -p0 -i /third-party/diffs/mstpd.diff; make -j 4 install

RUN pip install tenjin

RUN echo "set nu" >> /root/.vimrc
RUN echo "set hlsearch" >> /root/.vimrc
RUN echo "set et" >> /root/.vimrc
RUN echo "set tabstop=2" >> /root/.vimrc
RUN echo "set shiftwidth=2" >> /root/.vimrc
RUN echo "set autoindent" >> /root/.vimrc
RUN echo "set smartindent" >> /root/.vimrc

# install additional bmv2 deps
RUN mkdir -p /scripts/travis
COPY scripts/install-thrift.sh /scripts/travis
COPY scripts/install-nanomsg.sh /scripts/travis
COPY scripts/install-nnpy.sh /scripts/travis
COPY scripts/check-nnpy.py /scripts/travis
RUN mkdir __trash; cd __trash; \
    bash ../scripts/travis/install-thrift.sh; \
    bash ../scripts/travis/install-nanomsg.sh; \
    sudo ldconfig; \
    bash ../scripts/travis/install-nnpy.sh; \
    cd ..; rm -rf __trash;


ADD ntf /ntf

RUN cd /ntf/p4-hlir ; \
    python setup.py install

ENV VTYSH_PAGER more
