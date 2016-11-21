NTF Network Test Framework

## Introduction

NTF is a python based network test framework. It is based on mininet and
unittest.

## Requisites

* Python 2.7 or higher
* Mininet version 2.2.1 or higher
* Docker version 1.10 or higher
* sudo privileges to run ntf

## Install

NTF can be installed using `sudo python setup.py install`

## Running Tests

Prior to running tests using NTF, the required docker image needs to be
present. Follow the examples/topology/l2_topology.json and
examples/topology/config.json to define topology and the switch properties.
Write the unittest case to use the topology as in
examples/tests/switch_tests.py. Run NTF as below:

    sudo ./ntf --topology <topologyfile_with_path> --config <configfile_with_path>
    --test-dir <test_directory> --test <testname>

optional parameters:

    --cli: To get to mininet cli prompt during test.
    --log-file <filename>: Filename to use for logging
    --log-dir <log_dir>: Folder to write the logfile to.
