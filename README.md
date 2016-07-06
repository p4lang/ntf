NTF - Network Test Framework
===

This repository contains sample mininet and docker infrastructure required to perform network tests on various applications on Behavioral Model version 2

The directory structure of NTF repository is shown below:

    ─── ntf	                             Docker and Mininet Infrastructure framework
        ├── apps                         Reference applications
        ├── bmv2			             Folder to run BMv2 model
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
        └── tools                        Various setup scripts


## Important: Pulling Submodules required by NTF
Two scripts are provided in this repo to manage the submodules needed.
Script to pull the submodules
```sh
cd ntf
./pull_submodules.sh
```
Script to update the submodules
```sh
cd ntf
./update_submodules.sh
```

## Important: Installing Submodule dependencies
Find the steps to install the dependencies needed for the submodules [p4-bmv2], [p4c-bmv2], and [switch] from the embedded github links. You will find the submodules cloned in the parent directory of NTF repo. 

## NTF - Dependencies


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
Find below the steps to install docker
```sh
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $(whoami)
```
Logout and Log back in to activate new groups

#### Other dependencies
```sh
cd ntf
./install_ntf_deps.sh
sudo tools/veth_setup.sh
```
The below script is intended to set up an environment suitable for building and running P4 programs. This is optional if you just want to perform tests using the NTF repository.
```sh
cd ntf
sudo ./tools/bootstrap.py
```



#### Running PTF tests
We have provided a script that will help you build and compile the switch to run ptf tests
```sh
cd ntf/bmv2
./run_build_for_ptf.sh
```

Once everything has compiled, you can run the tests for switch.p4 (Please make sure that you have all the necessary veth pairs setup (you can use [tools/veth_setup.sh]). Execute each of the below commands in separate windows

```sh
cd ntf/bmv2/build/switch
sudo ./bmv2/run_bm.sh
sudo ./bmv2/run_drivers.sh
sudo PYTHONPATH=$PYTHONPATH:../ptf/lib.linux-x86_64-2.7 ./bmv2/run_tests.sh --test-dir <SWITCH>/tests/ptf-tests/api-tests
```
SWITCH - Absoulte path of the cloned switch submodule

#### Running Reference Applications
* Inband Network Telemetry : 

	This is a reference implementation of the Inband Network Telemetry (from now called just "INT") specification, which allows programmable switches to embed telemetry information directly into data packets. Set up instructions for the INT demo can be found [here]

   [switch]: <https://github.com/p4lang/switch.git>
   [p4-bmv2]: <https://github.com/p4lang/behavioral-model.git>
   [p4c-bmv2]: <https://github.com/p4lang/p4c-bm.git>
   [tools/veth_setup.sh]: <https://github.com/p4lang/ntf/blob/master/tools/veth_setup.sh>
   [here]: <https://github.com/p4lang/ntf/tree/master/apps/int> 
