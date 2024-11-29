#!/bin/bash

# Запрашиваем имя файла и слово для поиска
echo "Введите имя файла:"
read filename

echo "Введите слово для поиска:"
read search_word

# Проверяем, существует ли файл
if [ ! -f "$filename" ]; then
    echo "Файл $filename не существует."
    exit 1
fi

# Подсчитываем количество вхождений слова
count=$(grep -o "\b$search_word\b" "$filename" | wc -l)

# Выводим результат
echo "Слово '$search_word' встречается в файле '$filename' $count раз(а)."
