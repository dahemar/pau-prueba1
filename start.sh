#!/bin/bash
cd "$(dirname "$0")"
echo "Iniciando servidor en http://localhost:8000"
echo "Presiona Ctrl+C para detener el servidor"
python3 -m http.server 