uptime

echo

# Print Cpu usage from top command, specifically by subtracting idle time from 100 to get usage
top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{ print "CPU Usage: " 100-$1 "%" " (Idle: " $1 "%)" }'
