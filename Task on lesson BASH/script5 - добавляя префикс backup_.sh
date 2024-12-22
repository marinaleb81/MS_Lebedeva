#!/bin/bash

# Запрашиваем путь к директории
echo "Введите путь к директории:"
read directory

# Проверяем, существует ли директория
if [ ! -d "$directory" ]; then
    echo "Указанная директория не существует."
    exit 1
fi

# Проходим по всем файлам в директории
for file in "$directory"/*; do
    # Проверяем, является ли элемент файлом (а не директорией)
    if [ -f "$file" ]; then
        # Получаем имя файла без пути
        filename=$(basename "$file")
        # Переименовываем файл, добавляя префикс "backup_"
        mv "$file" "$directory/backup_$filename"
        echo "Переименован: $filename -> backup_$filename"
    fi
done

echo "Все файлы в директории переименованы."
