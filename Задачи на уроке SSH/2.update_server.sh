#!/bin/bash

# Параметры
REMOTE_USER="user"                  # Имя пользователя на удалённом сервере
REMOTE_HOST="192.168.31.83"         # IP или хост удалённого сервера
EMAIL="fed.mafy@gmail.com"       	# Email для уведомлений
LOG_FILE="./update_log.txt"         # Локальный файл для логов

# Подключение к серверу и выполнение обновлений
echo "=== $(date) ===" >> $LOG_FILE
echo "Подключение к $REMOTE_HOST для обновления системы..." | tee -a $LOG_FILE

# Выполнение команд обновления и проверки через SSH
ssh "$REMOTE_USER@$REMOTE_HOST" "
    echo 'Проверка наличия обновлений...';
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y;
    echo 'Обновления установлены.';
    
    # Проверка необходимости перезагрузки
    if [ -f /var/run/reboot-required ]; then
        echo 'Требуется перезагрузка системы. Выполняю перезагрузку...';
        sudo reboot;
    else
        echo 'Перезагрузка не требуется.';
    fi
"

# Проверка перезагрузки и отправка уведомления
if [ $? -eq 0 ]; then
    echo "Обновления завершены успешно." | tee -a $LOG_FILE
    if ssh "$REMOTE_USER@$REMOTE_HOST" "test -f /var/run/reboot-required"; then
        echo "Сервер был перезагружен. Отправка уведомления на $EMAIL..."
        echo "Сервер $REMOTE_HOST был перезагружен после обновления." | mail -s "Уведомление: Перезагрузка сервера" "$EMAIL"
    fi
else
    echo "Ошибка при обновлении или подключении." | tee -a $LOG_FILE
fi
