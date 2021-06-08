#!/usr/bin/env bash
cd /root
if [[ ! -e /root/my_watchfrr.pp && -e /root/my_watchfrr.te ]]
    then
        checkmodule -M -m  ./my_watchfrr.te -o ./my_watchfrr.mod
        semodule_package -m ./my_watchfrr.mod -o ./my_watchfrr.pp
        semodule -i ./my_watchfrr.pp

fi
