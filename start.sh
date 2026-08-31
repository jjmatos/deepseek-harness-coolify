#!/bin/sh
set -eu

echo "Starting dsh web on 127.0.0.1:8081..."

# Ejecuta dsh y captura stderr
dsh web --port 8081 --no-open 2>&1 &
DSH_PID=$!

echo "Waiting for dsh to be ready (PID: $DSH_PID)..."

# Espera 10 segundos para que DSH inicie completamente
sleep 10

# Verifica que el proceso sigue vivo
if ! kill -0 "$DSH_PID" 2>/dev/null; then
  echo "ERROR: dsh exited immediately after startup."
  exit 1
fi

# Verifica que el puerto está escuchando
if ! curl -fsS http://127.0.0.1:8081/ >/dev/null 2>&1; then
  echo "ERROR: dsh is not responding on port 8081."
  kill "$DSH_PID" 2>/dev/null || true
  exit 1
fi

echo "dsh is ready on 127.0.0.1:8081."

echo "Starting socat on 0.0.0.0:9081..."
exec socat TCP-LISTEN:9081,reuseaddr,fork TCP:127.0.0.1:8081
