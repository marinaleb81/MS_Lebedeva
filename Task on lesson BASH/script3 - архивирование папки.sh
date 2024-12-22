#!/bin/bash

# Запрашиваем путь к директории
echo "Введите путь к директории, которую нужно архивировать:"
read directory

# Проверяем, существует ли директория
if [ ! -d "$directory" ]; then
    echo "Указанная директория не существует."
    exit 1
fi

# Получаем текущую дату в формате ГГГГ-ММ-ДД
current_date=$(date +%Y-%m-%d)

# Создаём имя архива с датой
archive_name="$(basename "$directory")-$current_date.tar.gz"

# Создаём архив
tar -czf "$archive_name" "$directory"

# Выводим сообщение об успешном создании архива
echo "Архив успешно создан: $archive_name"
