#!/bin/bash
sudo apt-get update
sudo apt-get stress -y
stress --cpu 2 --timeout 30 &
STRESS_PID=$!
sleep 10
if !curl -s --fail /dev/null  http://localhost:1999
echo "dashboard is unacessible"
kill $STRESS_PID>/dev/null
exit
else
  echo "dashboard is accessible "
  fi
  echo "Checking for CPU usage alert in Netdata logs..."
if grep -i "ALERT" /var/log/netdata/error.log | grep -i "cpu" > /dev/null; then
    echo "CPU usage alert detected in Netdata logs"
else
    echo "No CPU usage alert detected (check alert configuration)"
fi
  echo "Cleaning up stress processes..."
kill $STRESS_PID 2>/dev/null
rm -f /tmp/testfile

echo "Dashboard test completed. Check http://localhost:19999 for metrics."