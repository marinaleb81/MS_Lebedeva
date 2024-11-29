#!/bin/bash

# Настройки
LOCAL_DIR="/path/to/local/directory"           # Локальная директория
REMOTE_USER="username"                         # Пользователь удалённого сервера
REMOTE_HOST="remote.server.com"                # Хост удалённого сервера
REMOTE_DIR="/path/to/remote/directory"         # Удалённая директория
EXCLUDE_FILE="/path/to/exclude-list.txt"       # Файл с исключениями (может быть пустым)
EMAIL="your_email@example.com"                 # E-mail для отправки отчёта
LOG_FILE="/tmp/sync_files_$(date +'%Y-%m-%d_%H-%M-%S').log" # Лог файл

# Функция для синхронизации файлов
sync_files() {
    echo "=== СИНХРОНИЗАЦИЯ НАЧАЛАСЬ: $(date) ===" > "$LOG_FILE"

    # Синхронизация с локальной на удалённую директорию
    echo "-> Синхронизация локальной директории на удалённую..." >> "$LOG_FILE"
    rsync -avz --delete --exclude-from="$EXCLUDE_FILE" -e ssh "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE" 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Синхронизация локальной директории успешно завершена." >> "$LOG_FILE"
    else
        echo "Ошибка синхронизации локальной директории." >> "$LOG_FILE"
    fi

    # Синхронизация с удалённой на локальную директорию
    echo "-> Синхронизация удалённой директории на локальную..." >> "$LOG_FILE"
    rsync -avz --delete --exclude-from="$EXCLUDE_FILE" -e ssh "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR" >> "$LOG_FILE" 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Синхронизация удалённой директории успешно завершена." >> "$LOG_FILE"
    else
        echo "Ошибка синхронизации удалённой директории." >> "$LOG_FILE"
    fi

    echo "=== СИНХРОНИЗАЦИЯ ЗАВЕРШЕНА: $(date) ===" >> "$LOG_FILE"
}

# Функция для отправки отчёта
send_email_report() {
    echo "-> Отправка отчёта на $EMAIL..." >> "$LOG_FILE"
    if mail -s "Отчёт о синхронизации файлов" "$EMAIL" < "$LOG_FILE"; then
        echo "Отчёт успешно отправлен на $EMAIL." >> "$LOG_FILE"
    else
        echo "Не удалось отправить отчёт на $EMAIL." >> "$LOG_FILE"
    fi
}

# Проверка наличия rsync
if ! command -v rsync &> /dev/null; then
    echo "Ошибка: rsync не установлен. Установите rsync и повторите запуск." >> "$LOG_FILE"
    exit 1
fi

# Основной процесс
sync_files
send_email_report
