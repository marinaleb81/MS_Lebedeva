#!/bin/bash

# Текущая директория
directory="."

# Удаляем файлы с именами в формате "backup_*_*.*", старше 7 дней
find "$directory" -type f -name "backup_*_*.*" -mtime +7 -exec rm -v {} \;

echo "Все файлы с именами 'backup_*_*.*' старше 7 дней удалены."
