#!/bin/bash
sudo sysctl net.ipv6.conf.all.disable_ipv6=1
sudo sysctl net.ipv6.conf.default.disable_ipv6=1
sudo sysctl net.ipv6.conf.lo.disable_ipv6=1
