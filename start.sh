#!/bin/bash

function startup {
    service mongodb start
    if [ ! -e /lxHive/src/xAPI/Config/Config.yml ]; then
        initialize
    fi
    service apache2 start
}

function initialize {
    /lxHive/X setup:db -n -q
    /lxHive/X setup:oauth -n
}

function terminate {
    echo "Terminating lxHive container"
    service mongodb stop
    service apache2 stop
}
trap terminate HUP INT QUIT TERM

startup
if [ -t 1 ]; then # we have a terminal
    bash
else
    while true; do sleep 3600; done
fi
terminate

