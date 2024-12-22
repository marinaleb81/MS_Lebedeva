#!/bin/bash

# Запрашиваем имя файла
echo "Введите имя файла:"
read filename

# Проверяем, существует ли файл
if [ ! -f "$filename" ]; then
    echo "Ошибка: файл '$filename' не существует."
    exit 1
fi

echo "Введите слово, которое нужно заменить:"
read old_word

echo "Введите новое слово:"
read new_word

# Замена слова с использованием sed
sed -i "s/\b$old_word\b/$new_word/g" "$filename"

# Вывод результата
echo "Все вхождения слова '$old_word' заменены на '$new_word' в файле '$filename'."
