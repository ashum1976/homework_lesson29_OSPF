#!/usr/bin/env bash
sysctl net.ipv4.conf.all.forwarding=1
sysctl net.ipv4.conf.all.rp_filter=0
