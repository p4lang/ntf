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

from mininet.cli import CLI
from ntf import config
from time import sleep
import unittest


class L2(unittest.TestCase):
    def setUp(self):
        self.net = config['net']
        self.hosts = self.net.hosts
        self.sws = self.net.switches

    def runTest(self):

        result = self.net.ping(self.hosts, 30)

        if config['cli']:
            CLI(self.net)

        if result != 0:
            for host in self.hosts:
                print host.cmd('ifconfig')
                print host.cmd('arp -n')

            for sw in self.sws:
                print sw.cmd('arp -n')

    def tearDown(self):
        pass
