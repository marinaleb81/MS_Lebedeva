#!/bin/bash

# Запрашиваем исходную директорию
echo "Введите путь к исходной директории:"
read source_dir

# Проверяем существование исходной директории
if [ ! -d "$source_dir" ]; then
    echo "Ошибка: Директория '$source_dir' не существует."
    exit 1
fi

# Запрашиваем директорию назначения
echo "Введите путь к директории назначения:"
read target_dir

# Проверяем существование директории назначения, если её нет, создаём
if [ ! -d "$target_dir" ]; then
    echo "Директория назначения не существует. Создаю..."
    mkdir -p "$target_dir"
fi

# Получаем текущую дату в формате YYYY-MM-DD
current_date=$(date +%Y-%m-%d)

# Копируем файлы с добавлением даты к имени
for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file") # Извлекаем имя файла
        cp "$file" "$target_dir/${current_date}_$filename"
        echo "Скопирован файл: $file -> $target_dir/${current_date}_$filename"
    fi
done

echo "Готово :)"
