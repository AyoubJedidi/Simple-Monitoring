#!/bin/bash
echo "stoping netdata"
sudo systemctl stop netdata
sudo apt-get pruge netdata -y
sudo apt-get autoremove -y
echo "removing configuration files"
sudo rm -rfv  /etc/netdata
echo "removing logs "
sudo rm -rfv /var/log/netdata
echo "removing cache"
sudo rm -rfv /var/cache/netdata
if !curl -s --fail /dev/null  http://localhost:1999
    echo "netdata is no longer available"
    else echo "netdata is still available please check manually"
    fi

echo "deleting netdata successuflly"
