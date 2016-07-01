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

thisdir := $(shell pwd)

setup-docker-image:
	@sudo rm -fr /tmp/docker_tmp
	@mkdir -p /tmp/docker_tmp/ntf
	@cp -r $(thisdir)/../docker/* /tmp/docker_tmp
	@cp -rf $(thisdir)/../../ntf/bmv2 /tmp/docker_tmp/ntf
	@cp -rf $(thisdir)/../../p4-hlir /tmp/docker_tmp/ntf
	@cp -rf $(thisdir)/../../ntf/tools /tmp/docker_tmp/ntf
	@cp /tmp/docker_tmp/start.sh /tmp/docker_tmp/ntf/tools/start.sh
	@cp /tmp/docker_tmp/startv2.sh /tmp/docker_tmp/ntf/tools/startv2.sh
	@cp /tmp/docker_tmp/bm_start.sh /tmp/docker_tmp/ntf/tools/bm_start.sh

bmv2-docker-image : setup-docker-image
	@echo "CMD /bin/bash" >> /tmp/docker_tmp/Dockerfile
	@sudo docker build -t p4dockerswitch_bmv2 /tmp/docker_tmp
	@rm -fr /tmp/docker_tmp


