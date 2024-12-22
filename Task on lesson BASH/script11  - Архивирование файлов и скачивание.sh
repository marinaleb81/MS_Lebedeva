# Переменные
REMOTE_SERVER="user@192.168.31.83"
REMOTE_DIR="/home/user/MS_Lebedeva/"
ARCHIVE_NAME="backup_$(date +%F).tar.gz"
LOCAL_BACKUP_DIR="e:/Вэб инжениринг/Задачи на уроке SSH/backup"
LOCAL_DIR="e:/Вэб инжениринг/Задачи на уроке SSH/backup"
REMOTE_EXTRACT_DIR="/home/user/MS_Lebedeva/extracted"
REMOTE_ARCHIVE="/tmp/$ARCHIVE_NAME"

# Архивация на удалённом сервере (Вариант со скриптом)
ssh $REMOTE_SERVER "tar -czf /tmp/$ARCHIVE_NAME -C $REMOTE_DIR ."

# Разархивация на удалённом сервере (Вариант со скриптом)
ssh $REMOTE_SERVER "mkdir -p $REMOTE_EXTRACT_DIR && tar -xzf $REMOTE_ARCHIVE -C $REMOTE_EXTRACT_DIR"

# через PowerShell

# Создание архива на удалённом сервере
ssh user@192.168.31.83 "tar -czf /home/user/MS_Lebedeva/backup_$(date +%F).tar.gz -C /home/user/MS_Lebedeva ."

# Скачивание архива на локальную машину
scp user@192.168.31.83:/home/user/MS_Lebedeva/backup_$(date +%F).tar.gz "e:/Вэб инжиниринг/Задачи на уроке SSH/backup/backup_$(date +%F).tar.gz"

# Разархивация на локальной машине
tar -xzf "e:/Вэб инжиниринг/Задачи на уроке SSH/backup/backup_$(date +%F).tar.gz" -C "e:/Вэб инжиниринг/Задачи на уроке SSH/backup/extracted/"

# Удаление архива на удалённом сервере
ssh user@192.168.31.83 "rm /home/user/MS_Lebedeva/backup_$(date +%F).tar.gz"
