#!/bin/bash

# Настройки
REMOTE_USER="username"                           # Пользователь удалённого сервера
REMOTE_HOST="remote.server.com"                  # Хост удалённого сервера
CPU_THRESHOLD=1.5                                # Порог загрузки процессора (средняя за 1 минуту)
CHECK_INTERVAL=30                                # Интервал проверки в секундах
TARGET_PROCESSES=("process1" "process2")         # Список процессов для завершения

# Проверка текущей загрузки процессора на удалённом сервере с использованием uptime
check_cpu_usage() {
    ssh "$REMOTE_USER@$REMOTE_HOST" "uptime | awk -F'load average:' '{print \$2}' | cut -d',' -f1 | xargs"
}

# Завершение процессов с заданными именами
kill_high_load_processes() {
    for process in "${TARGET_PROCESSES[@]}"; do
        echo "Проверка процесса: $process..."
        ssh "$REMOTE_USER@$REMOTE_HOST" "pkill -f $process && echo 'Процесс $process завершён' || echo 'Процесс $process не найден'"
    done
}

# Основной цикл проверки
monitor_cpu() {
    while true; do
        echo "Проверка загрузки процессора..."
        CPU_LOAD=$(check_cpu_usage)
        CPU_LOAD=$(echo "$CPU_LOAD" | xargs) # Убираем лишние пробелы

        echo "Текущая средняя загрузка CPU за 1 минуту: $CPU_LOAD"
        # Сравнение с порогом
        if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
            echo "ВНИМАНИЕ: Загрузка процессора превышает $CPU_THRESHOLD"
            kill_high_load_processes
        else
            echo "Загрузка процессора в норме."
        fi

        echo "Ожидание $CHECK_INTERVAL секунд..."
        sleep "$CHECK_INTERVAL"
    done
}

# Проверка наличия ssh
if ! command -v ssh &> /dev/null; then
    echo "Ошибка: SSH не установлен. Установите SSH и повторите запуск."
    exit 1
fi

# Проверка наличия bc (для сравнения с плавающей точкой)
if ! command -v bc &> /dev/null; then
    echo "Ошибка: bc не установлен. Установите bc и повторите запуск."
    exit 1
fi

# Запуск мониторинга
monitor_cpu
