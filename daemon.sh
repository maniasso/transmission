#!/bin/sh

set -x

trap 'kill -TERM $PID' TERM INT

if [ "$#" -eq 0 ]; then
  transmission-daemon -c /download/incomplete -w /download -f -a *.*.*.* -p "$PORT" -g /config &
else
  transmission-daemon $@ &
fi

PID=$!
wait $PID
wait $PID
while [ -f /config/lock ]
do
  sleep 2
done

EXIT_STATUS=$?
