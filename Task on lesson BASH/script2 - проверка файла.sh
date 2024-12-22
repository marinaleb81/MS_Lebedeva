#!/bin/bash

# Запрос имени файла у пользователя
echo "Введите имя файла:"
read filename

# Проверка существования файла
if [ -e "$filename" ]; then
    echo "Файл найден!"
else
    echo "Файл не найден."
fi
