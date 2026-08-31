#!/bin/sh
set -e

echo "Starting dsh web..."
dsh web --port 8081 --no-open &
DSH_PID=$!

echo "Waiting for dsh to be ready..."
for i in $(seq 1 30); do
  if curl -s http://127.0.0.1:8081 >/dev/null 2>&1; then
    echo "dsh is ready on port 8081!"
    break
  fi
  if [ $i -eq 30 ]; then
    echo "ERROR: dsh failed to start"
    exit 1
  fi
  sleep 1
done

echo "Starting socat on port 9081..."
exec socat TCP-LISTEN:9081,fork TCP:127.0.0.1:8081
