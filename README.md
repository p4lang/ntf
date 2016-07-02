NTF - Network Test Framework
===

This repository contains sample mininet and docker infrastructure required to perform network tests on various applications on Behavioral Model version 2

## Important: Pulling Submodules required by NTF
Two scripts are provided in this repo to manage the submodules needed.
Script to pull the submodules
```sh
./pull_submodules.sh
```
Script to update the submodules
```sh
./update_submodules.sh
```

## Important: Installing Submodule dependencies
Find the steps to install the dependencies needed for the submodules [p4-bmv2], [p4c-bmv2], and [switch] from the embedded github links. You will find the submodules cloned in the parent directory of NTF repo. You 

## NTF - Dependencies


#### Mininet
Find below the steps to install mininet
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
./install_deps.sh
```
The below script is intended to set up an environment suitable for building and running P4 programs. This is optional if you just want to perform tests using the NTF repository.
```sh
sudo ./tools/bootstrap.py
```



#### Running PTF tests
We have provided a script that will help you build and compile the switch to run ptf tests
```sh
cd bmv2
./run_build_for_ptf.sh
```

Once everything has compiled, you can run the tests for switch.p4 (Please make sure that you have all the necessary veth pairs setup (you can use [tools/veth_setup.sh]). Execute each of the below commands in separate windows

```sh
cd bmv2/build/switch
sudo ./bmv2/run_bm.sh
sudo ./bmv2/run_drivers.sh
sudo PYTHONPATH=$PYTHONPATH:../ptf/lib.linux-x86_64-2.7 ./bmv2/run_tests.sh --test-dir <SWITCH>/tests/ptf-tests/api-tests
```
SWITCH - Absoulte path of the cloned switch submodule

   [switch]: <https://github.com/barefootnetworks/switch.git>
   [p4-bmv2]: <https://github.com/barefootnetworks/p4l-bmv2.git>
   [p4c-bmv2]: <https://github.com/barefootnetworks/p4l-p4c-bmv2.git>i
   [tools/veth_setup.sh]: <https://github.com/p4lang/ntf/blob/master/tools/veth_setup.sh> 
