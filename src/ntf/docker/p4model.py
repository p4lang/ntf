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

from docker_node import *


class P4DockerSwitch(DockerSwitch):
    def __init__(self,
                 name,
                 pcap_dump=False,
                 startup="",
                 switch_info="", **kwargs):
        self.log_file = "docker.log"
        self.pcap_dump = pcap_dump
        self.startup = startup

        DockerSwitch.__init__(self, name, **kwargs)

    def start(self, controllers):
        ## load the startup configuration
        print self.startup

        cmd = ['docker', 'exec', self.name, '/bin/bash', self.startup]
        bmp = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            close_fds=True)
        bmp.wait()

    def execProgram(self, program):
        cmd = ['docker', 'exec', self.name, '/bin/bash', program]
        pid = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            close_fds=False)
        pid.wait()
