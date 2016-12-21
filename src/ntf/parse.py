##############################################################################
# Copyright 2013-present Barefoot Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################
###############################################################################

from distutils.version import StrictVersion
from docker.p4model import *
from mininet.net import Mininet, VERSION
from mininet.log import setLogLevel, info
from mininet.cli import CLI
from pprint import pprint
from time import sleep
import json
import logging
import sys


class Config(object):
    """
    class Config
        Load and store config file information
    """

    config_info = {}

    def __init__(self, config_file):
        logging.info("Config File: %s" % config_file)
        with open(config_file) as json_file:
            self.config_info = json.load(json_file)
        logging.info("Config File Info: %s" % self.config_info)

    def get_item(self, item):
        return self.config_info[item]


class Topology(object):
    """
    class Topology
        Load and store topology file information
    """

    topology = {}

    def __init__(self, topology_file):
        logging.info("Topology File: %s" % topology_file)
        with open(topology_file) as json_file:
            self.topology = json.load(json_file)
        logging.info("Topology File Info: %s" % self.topology)

    def get_item(self, item):
        return self.topology[item]


class Deploy(object):
    """
    class Deploy
        Build topology
    """

    sw_list = {}
    host_list = {}
    connectivity = {}
    configObj = ""
    net = ""
    hostObj = {}
    swObj = {}

    def __init__(self, topology, configObj):
        logging.info("Deploy the topology")
        self.sw_list = topology.get_item("switches")
        self.host_list = topology.get_item("hosts")
        self.connectivity = topology.get_item("connectivity")
        self.configObj = configObj
        self.net = Mininet(controller=None)

        logging.info("----------")
        logging.info(self.sw_list)
        logging.info(self.host_list)
        logging.info(self.connectivity)
        logging.info(self.configObj)
        logging.info("----------")

    def deploy_switches(self):
        for swname in self.sw_list:
            logging.info(swname)
            port_map = []
            fs_map = []
            sinfo = ""
            cls = ""
            image = ""
            ifmapfile = ""
            startfile = ""
            for name, value in self.sw_list[swname].iteritems():
                logging.info(name)
                logging.info(value)
                if name == "type":
                    sinfo = self.configObj.get_item(value)
                    logging.info(sinfo)
                    swtype = sinfo["type"]
                    if swtype == "docker":
                        image = sinfo["name"]
                        cls = P4DockerSwitch
                        for mvol, vol in sinfo["mounts"].iteritems():
                            # check that the mvol path exists
                            if os.path.isdir(mvol):
                                fs_map.append([mvol, vol])
                            else:
                                raise Exception("Volume %s does not exist"
                                                % mvol)
                elif name == "configs":
                    for mport, port in value["port_map"].iteritems():
                        port_map.append([int(mport), int(port)])
                    if "ifmap" in value:
                        ifmapfile = value["ifmap"]
                    if "startup_config" in value:
                        startfile = value["startup_config"]

                if startfile == "":
                    raise Exception("Startup config file not provided ...")
                self.swObj[str(swname)] = self.net.addSwitch(str(swname),
                                                             image=image,
                                                             cls=cls,
                                                             fs_map=fs_map,
                                                             pcap_dump=True,
                                                             port_map=port_map,
                                                             startup=startfile,
                                                             switch_info=sinfo)

    def deploy_hosts(self):
        for hostname in self.host_list:
            logging.info(hostname)
            # see if you can mount or copy to the mininet host
            for ethname, value in self.host_list[hostname].iteritems():
                if ethname == "eth0":
                    ipaddr = self.host_list[hostname][ethname]["address"]
                    prefix = self.host_list[hostname][ethname]["prefix"]
                    ipstr = ipaddr + "/" + prefix
                    if "mac" in self.host_list[hostname][ethname]:
                        mac = self.host_list[hostname][ethname]["mac"]
                        self.hostObj[str(hostname)] = \
                            self.net.addHost(str(hostname), ip=ipstr,
                                             mac=mac)
                    else:
                        self.hostObj[str(hostname)] = \
                            self.net.addHost(str(hostname), ip=ipstr)

    def add_links(self):
        for conn1, conn2 in self.connectivity.iteritems():
            devname1, port1 = conn1.split(":")
            devname2, port2 = conn2.split(":")
            dev1 = self.get_dev(str(devname1))
            dev2 = self.get_dev(str(devname2))
            logging.info("********")
            logging.info(type(dev1))
            logging.info(int(port1))
            logging.info(dev1.cmd('ifconfig'))
            logging.info("********")
            logging.info(type(dev2))
            logging.info(int(port2))
            logging.info(dev2.cmd('ifconfig'))
            logging.info("********")
            if dev1 != "" and dev2 != "":
                self.net.addLink(dev1, dev2, port1=int(port1),
                                 port2=int(port2), fast=False)
            logging.info(dev1.cmd('ifconfig'))
            logging.info(dev2.cmd('ifconfig'))

    def get_hosts(self):
        return self.hostObj

    def get_net(self):
        return self.net

    def get_dev(self, devname):
        return self.net.get(devname)

    def stop_net(self):
        return self.net.stop()

    def start_net(self):
        return self.net.start()

    def cli_net(self):
        return CLI(self.net)
