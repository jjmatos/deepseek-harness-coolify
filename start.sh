#!/bin/sh
set -eu

echo "Starting dsh web on 127.0.0.1:8081..."
dsh web --port 8081 --no-open &
DSH_PID=$!

echo "Waiting for dsh to be ready..."

i=0
while [ "$i" -lt 60 ]; do
  if ! kill -0 "$DSH_PID" 2>/dev/null; then
    echo "ERROR: dsh exited during startup."
    wait "$DSH_PID" || true
    exit 1
  fi

  if curl -fsS http://127.0.0.1:8081/ >/dev/null; then
    echo "dsh is ready on 127.0.0.1:8081."
    break
  fi

  i=$((i + 1))
  sleep 1
done

if [ "$i" -eq 60 ]; then
  echo "ERROR: dsh did not become ready within 60 seconds."
  kill "$DSH_PID" 2>/dev/null || true
  exit 1
fi

echo "Starting socat on 0.0.0.0:9081..."
exec socat TCP-LISTEN:9081,reuseaddr,fork TCP:127.0.0.1:8081
