#!/bin/bash

# Параметры
REMOTE_USER="user"                     			# Имя пользователя на удалённом сервере
REMOTE_HOST="192.168.31.83"            			# IP или хост удалённого сервера
REMOTE_DIR="/home/user/MS_Lebedeva/backups" 	# Удалённая директория для архивации
LOCAL_DIR="./downloads"                			# Локальная папка для скачивания архива
ARCHIVE_NAME="backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"

# 1. Архивирование директории на удалённом сервере
echo "Архивирование директории $REMOTE_DIR на удалённом сервере..."
ssh "$REMOTE_USER@$REMOTE_HOST" "
    tar -czf /tmp/$ARCHIVE_NAME -C $(dirname "$REMOTE_DIR") $(basename "$REMOTE_DIR")
"
if [ $? -ne 0 ]; then
    echo "Ошибка при создании архива на удалённом сервере."
    exit 1
fi
echo "Архив /tmp/$ARCHIVE_NAME успешно создан на сервере."

# 2. Скачивание архива на локальную машину
mkdir -p "$LOCAL_DIR"
echo "Скачивание архива на локальную машину в $LOCAL_DIR..."
scp "$REMOTE_USER@$REMOTE_HOST:/tmp/$ARCHIVE_NAME" "$LOCAL_DIR/"
if [ $? -ne 0 ]; then
    echo "Ошибка при скачивании архива."
    exit 1
fi
echo "Архив успешно скачан в $LOCAL_DIR/$ARCHIVE_NAME."

# 3. Распаковка архива
echo "Распаковка архива в $LOCAL_DIR..."
tar -xzf "$LOCAL_DIR/$ARCHIVE_NAME" -C "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Ошибка при распаковке архива."
    exit 1
fi
echo "Архив успешно распакован в $LOCAL_DIR."

# 4. Удаление архива на удалённом сервере (опционально)
echo "Удаление архива на удалённом сервере..."
ssh "$REMOTE_USER@$REMOTE_HOST" "rm -f /tmp/$ARCHIVE_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка при удалении архива на сервере."
    exit 1
fi
echo "Архив успешно удалён с удалённого сервера."
