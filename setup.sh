#!/bin/bash
sudo apt update
echo "installing Netdata"
bash <(curl -s https://get.netdata.cloud/kickstart.sh)
echo "configuration"
sudo sed -i '/s/bind to = */bind to =0.0.0.0/' etc/netdata/netdata.conf
sudo ufw allow 1999/tcp
sudo bash -c 'touch > /etc/netdata/charts.d/cpu.conf << EOL
[system.cpu]
    priority = 100
    gap when lost iterations above = 1
    name = system.cpu
    chart_type = area
EOL'
echo "configuration of CPU alerts"
sudo bash -c 'cat > /etc/netdata/charts << EOL
alarm: high_cpu_usage
    on: system.cpu
    lookup: average -1m unaligned of user,system
    units: %
    every: 10s
    warn: \$this > 80
    crit: \$this > 90
    to: sysadmin
    info: CPU usage is too high
EOL'
sudo systemctl restart netdata
sudo systemctl status netdata
echo "Netdata installed and configured. Access the dashboard at http://localhost:19999"





