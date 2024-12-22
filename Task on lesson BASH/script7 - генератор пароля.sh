#!/bin/bash

# Запрашиваем длину пароля
echo "Введите длину пароля:"
read length

# Проверяем, является ли длина числом и больше 0
if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -le 0 ]; then
    echo "Ошибка: длина пароля должна быть положительным числом."
    exit 1
fi

# Генерируем пароль
password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!'\''_- ' | head -c "$length")

# Выводим результат
echo "Сгенерированный пароль: $password"
