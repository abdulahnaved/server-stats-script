#!/bin/bash

echo "========================="
echo "📊 SERVER PERFORMANCE STATS"
echo "Generated: $(date)"
echo "========================="

# 1. Total CPU Usage
echo -e "\n🧠 CPU Usage:"
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "Total CPU Usage: $CPU%"

# 2. Memory Usage
echo -e "\n💾 Memory Usage:"
free -m | awk '/^Mem:/ {
    total=$2; used=$3; free=$4;
    percent=used/total*100;
    printf "Used: %dMB | Free: %dMB | Total: %dMB | Usage: %.2f%%\n", used, free, total, percent;
}'

# 3. Disk Usage (root)
echo -e "\n🗄️ Disk Usage (Root '/'):"
df -h / | awk 'NR==2 {
    printf "Used: %s | Available: %s | Total: %s | Usage: %s\n", $3, $4, $2, $5
}'

# 4. Top 5 Processes by CPU usage
echo -e "\n🔥 Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# 5. Top 5 Processes by Memory usage
echo -e "\n💡 Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo -e "\n✅ Script completed successfully."

