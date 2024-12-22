#!/bin/bash

# Запрашиваем адрес сервера
echo "Введите адрес сервера (например, google.com):"
read server

# Пингуем сервер (одним пакетом)
if ping -c 1 "$server" > /dev/null 2>&1; then
    echo "Сервер $server доступен."
else
    echo "Сервер $server недоступен."
fi
