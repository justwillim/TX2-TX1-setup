for i in /sys/devices/virtual/thermal/thermal_zone*; do
    if [ -d "$i" ]; then
        printf "%-9s: %s\n" `cat $i/type`  `cat $i/temp`
    fi
done
