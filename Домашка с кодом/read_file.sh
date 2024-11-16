#!/bin/bash

# Запрашиваем имя файла
echo "Введите имя файла для чтения:"
read filename

# Проверяем, существует ли файл
if [ ! -f "$filename" ]; then
    echo "Ошибка: файл '$filename' не существует."
    exit 1
fi

# Чтение файла
cat "$filename" | while read line; do
    echo "$line"
done

echo "Готово :)"
