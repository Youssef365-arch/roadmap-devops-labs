echo -e "Uptime:\c"
uptime

echo

# Print Cpu usage from top command, specifically by subtracting idle time from 100 to get usage
top -bn1 | grep "%Cpu(s):" | cut -d "," -f 4 | awk '{ print "CPU Usage: " 100-$1 "%" " (Idle: " $1 "%)" }'

echo

# Total memory usage (Free vs Used including percentage)
free | grep Mem: | awk '{ printf "Memory Used: %.6f GiB (%.2f%%)\nMemory Free: %.6f GiB (%.2f%%)\n", $3/(1024^2), ($3/$2) * 100, $4/(1024^2), ($4/$2) * 100 }'

echo

# Disk Usage (Free vs Used including percentage)
df | grep C: | awk {' printf "Disk Used: %.2f GiB (%.2f%%)\nDisk Free: %.2f GiB (%.2f%%)\n", $3/(1024^2), ($3/$2)*100, $4/(1024^2), ($4/$2)*100 '}
