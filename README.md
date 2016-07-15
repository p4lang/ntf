NTF - Network Test Framework
===

This repository contains sample mininet and docker infrastructure required to perform network-wide tests of various applications on Behavioral Model version 2.

The directory structure of NTF repository is shown below:

    ─── ntf	                           Docker and Mininet Infrastructure framework
        ├── apps                         Reference applications
        ├── bmv2			               Folder to run BMv2 model
        │   ├── Makefile.bmv2		     Makefile to build and compile BMv2
        │   ├── run_build_for_ptf.sh     Script to run PTF tests
        │   └── run_build_submodules.sh  Script to build and Compile BMv2
        ├── docker
        │   ├── scripts                  Scripts to install dependencies inside docker
        │   ├── DockerFile               Specify dependencies for docker image
        │   └── startv2.sh               Script to setup CPU ports and front panel ports inside docker
        ├── makefiles
        │   └── docker.mk                makefile to specify docker target
        │── mininet                      Mininet scripts
        │   ├── docker                   Scripts for bmv2 docker support
        │   ├── int_cfg.py		         Helper script to simulate network for INT                   
        │   └── int_ref_topology.py      Mininet Script for INT 
        ├── pull_modules.sh		       script that clones required modules
        ├── update_modules.sh	           script that updates requires modules
        ├── install_ntf_deps.sh		   Dependency install script
        └── tools                        Various setup scripts

## Ubuntu Image
The ubuntu image that we use for our testing can be found here - [ubuntu-14.04.3-desktop-amd64.iso]

## Pulling modules required by NTF
Two scripts are provided in this repo to manage the modules needed.
Script to pull the modules.
```sh
cd ntf
./pull_modules.sh
```
Script to update the modules
```sh
cd ntf
./update_modules.sh
```

## Installing module dependencies
Below steps install the dependencies needed for the modules [p4-bmv2], [p4c-bmv2], and [switch]. You can find the modules cloned in the parent directory of NTF repo. 

```sh
cd ntf
./install_ntf_deps.sh
```

#### veth setup (needed after rebooting of the test machine)
```sh
cd ntf
sudo tools/veth_setup.sh
```

#### Mininet
Find below the steps to install mininet. These can be installed in any user desired path.
```sh
git clone git://github.com/mininet/mininet
cd mininet
git tag  # list available versions
git checkout -b 2.2.1 2.2.1
mininet/util/install.sh
```
#### Docker
Find below the steps to install docker.
```sh
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $(whoami)
```
Logout and Log back in to activate new groups.

## Build and test

NTF currently supports two different ways of building and running p4 switch. 

#### Build and run PTF tests
The first is to run PTF (Packet Test Framework) test on BMv2 switch running on the same host machine. We provide a script that will help you build and compile the switch to run ptf tests.

```sh
cd ntf/bmv2
./run_build_for_ptf.sh
```

Once everything has compiled via the script, you can run the tests for switch.p4 (make sure that you have all the necessary veth pairs setup by running [tools/veth_setup.sh]). Execute each of the sudo commands below in three separate terminals.

```sh
# in all three terminals
cd ntf/bmv2/build/switch

# terminal 1: run a switch model
sudo ./bmv2/run_bm.sh

# terminal 2: run switch driver, API server
sudo ./bmv2/run_drivers.sh

# terminal 3: run PTF unit tests
sudo PYTHONPATH=$PYTHONPATH:../ptf/lib.linux-x86_64-2.7 ./bmv2/run_tests.sh --test-dir ../../../../switch/tests/ptf-tests/api-tests
sudo PYTHONPATH=$PYTHONPATH:../ptf/lib.linux-x86_64-2.7 ./bmv2/run_tests.sh --test-dir ../../../../switch/tests/ptf-tests/pd-tests
```

Note that some PTF tests can occasionally fail due to statistical nature of them. You can re-run the failed test by specifying the test name at the end of the command as below, re-run multiple times, and check if the test passes in one of multiple runs.

```sh
sudo PYTHONPATH=$PYTHONPATH:../ptf/lib.linux-x86_64-2.7 ./bmv2/run_tests.sh --test-dir ../../../../switch/tests/ptf-tests/api-tests switch.L2LagFloodTest
```

#### Build docker image 

Another way is to launch a docker container that internally runs BMv2 switch, driver and API server. Linux networking can be used to configure and control the switch. See [switchlink](https://github.com/p4lang/switch/blob/master/switchlink/README.md) to understand how it works.   

* Build submodules for docker build

```sh
cd ntf/bmv2
./run_build_submodules.sh
```

* Build a docker image

```sh
cd ntf/makefiles
make -f docker.mk bmv2-docker-image
```

The docker containers can be launched by mininet, which eventually creates a complex network topology of switches and hosts. Each mininet switch is a docker container running a BMv2 model. We currently provide mininet scripts that consume the docker image and creates a topology of switches and hosts running an application called INT. 

* INT (Inband Network Telemetry) : 

	This is a reference implementation of the Inband Network Telemetry (from now called just "INT") specification, which allows programmable switches to embed telemetry information directly into data packets. Set up instructions for the INT demo can be found [here].

   [switch]: <https://github.com/p4lang/switch.git>
   [p4-bmv2]: <https://github.com/p4lang/behavioral-model.git>
   [p4c-bmv2]: <https://github.com/p4lang/p4c-bm.git>
   [tools/veth_setup.sh]: <https://github.com/p4lang/ntf/blob/master/tools/veth_setup.sh>
   [here]: <https://github.com/p4lang/ntf/tree/master/apps/int> 
   [ubuntu-14.04.3-desktop-amd64.iso]: <http://old-releases.ubuntu.com/releases/14.04.3/>
