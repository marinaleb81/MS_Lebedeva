#!/bin/bash

# Параметры
REMOTE_USER="user"                      # Пользователь на сервере
REMOTE_HOST="192.168.31.83"             # IP или хост сервера
THRESHOLD=20                            # Порог свободного места в гигабайтах
EMAIL="fed.mafy@gmail.com"          # Email для отправки уведомлений

# Проверка свободного места на сервере
echo "Проверка свободного места на сервере $REMOTE_HOST..."
FREE_SPACE=$(ssh "$REMOTE_USER@$REMOTE_HOST" "df -BG / | grep '/' | awk '{print \$4}' | sed 's/G//'")

if [ $? -ne 0 ]; then
    echo "Ошибка подключения или выполнения команды на сервере $REMOTE_HOST."
    exit 1
fi

echo "Свободное место на сервере: ${FREE_SPACE}G"

# Сравнение с порогом
if [ "$FREE_SPACE" -lt "$THRESHOLD" ]; then
    echo "Свободное место меньше порога ($THRESHOLD GB). Отправка уведомления на $EMAIL..."
    echo "Внимание! На сервере $REMOTE_HOST осталось всего ${FREE_SPACE} GB свободного места." | mail -s "Уведомление: Мало свободного места" "$EMAIL"
    if [ $? -ne 0 ]; then
        echo "Ошибка отправки уведомления на $EMAIL."
        exit 1
    fi
    echo "Уведомление отправлено."
else
    echo "Свободного места достаточно."
fi
