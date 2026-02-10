#!/usr/bin/env bash

# Remover arquivos de lock e node_modules
rm -rf node_modules
rm package-lock.json
rm -f yarn.lock

# Limpar cache do npm profundamente
npm cache clean --force
npm cache verify

# As vezes precisa remover cache manualmente
rm -rf ~/.npm/_cacache
rm -rf ~/.npm/_logs

# Reinstalar
npm install