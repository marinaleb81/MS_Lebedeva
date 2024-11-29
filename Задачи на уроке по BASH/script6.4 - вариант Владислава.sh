#!/bin/bash

# Определяем дату 7 дней назад
date_7_days_ago=$(date -d "-7 days" +%Y-%m-%d)

# Устанавливаем текущую директорию
dir="."

# Проходим по всем файлам с префиксом backup
for file in "$dir"/backup_*.txt; do
    # Извлекаем дату из имени файла в формате YYYY-MM-DD
    file_date=$(basename "$file" | sed -n 's/backup_\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)_.*/\1/p')

    # Проверяем, удалось ли извлечь дату
    if [[ -n "$file_date" ]]; then
        # Сравниваем даты
        if [[ "$file_date" > "$date_7_days_ago" ]]; then
            echo "Deleting $file"
            rm "$file"
        fi
    fi
done
