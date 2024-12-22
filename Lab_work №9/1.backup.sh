#!/bin/bash

# Параметры
SOURCE_DIR="./source" 							# Укажите исходную директорию
BACKUP_DIR="./backup"           				# Локальная директория для хранения архива
REMOTE_USER="user"                      		# Имя пользователя на удалённом сервере
REMOTE_HOST="192.168.31.83"             		# IP или хост удалённого сервера
REMOTE_DIR="/home/user/MS_Lebedeva/backups"     # Папка для архива на удалённом сервере

# Дата для имени архива
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup_$DATE.tar.gz"

# Создание резервной копии
mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"
echo "Архив создан: $BACKUP_DIR/$ARCHIVE_NAME"

# Передача архива на удалённый сервер
scp "$BACKUP_DIR/$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
if [ $? -eq 0 ]; then
    echo "Архив успешно передан на $REMOTE_HOST:$REMOTE_DIR"
else
    echo "Ошибка передачи архива" >&2
    exit 1
fi

# Удаление старых архивов на удалённом сервере (оставляем только 3 последних)
ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && ls -tp | grep -v '/$' | tail -n +4 | xargs -d '\n' rm --"
if [ $? -eq 0 ]; then
    echo "Старые архивы удалены на удалённом сервере"
else
    echo "Ошибка удаления старых архивов" >&2
    exit 1
fi

# Успешное завершение
echo "Резервное копирование завершено успешно"
