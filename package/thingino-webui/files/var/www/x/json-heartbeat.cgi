#!/bin/sh
echo "HTTP/1.1 200 OK
Content-type: application/json
Pragma: no-cache
Expires: $(TZ=GMT0 date +'%a, %d %b %Y %T %Z')
Etag: \"$(cat /proc/sys/kernel/random/uuid)\"
"
printf '{"time_now":"%s","timezone":"%s","mem_total":"%d","mem_active":"%d","mem_buffers":"%d","mem_cached":"%d","mem_free":"%d","overlay_total":"%d","overlay_used":"%d","overlay_free":"%d","daynight_value":"%d","uptime":"%s"}' \
	"$(date +%s)" \
	"$(cat /etc/timezone)" \
	"$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)" \
	"$(awk '/^Active:/ {print $2}' /proc/meminfo)" \
	"$(awk '/^Buffers:/ {print $2}' /proc/meminfo)" \
	"$(awk '/^Cached:/ {print $2}' /proc/meminfo)" \
	"$(awk '/^MemFree:/ {print $2}' /proc/meminfo)" \
	$(df | awk '/\/overlay/{print $2,$3,$4}') \
	"$(imp-control gettotalgain)" \
	"$(awk '{m=$1/60;h=m/60;printf "%sd %sh %sm %ss\n",int(h/24),int(h%24),int(m%60),int($1%60)}' /proc/uptime)"
