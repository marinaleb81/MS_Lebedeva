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

# через PowerShell
ssh user@192.168.31.83 "tar -czf /tmp/backup_$(date +%F).tar.gz -C /home/user/MS_Lebedeva ."

# Разархивация на удалённом сервере (Вариант со скриптом)
ssh $REMOTE_SERVER "mkdir -p $REMOTE_EXTRACT_DIR && tar -xzf $REMOTE_ARCHIVE -C $REMOTE_EXTRACT_DIR"

# через PowerShell
scp user@192.168.31.83:/tmp/backup_$(date +%F).tar.gz "e:/Вэб инжениринг/Задачи на уроке SSH/backup"  # Скачивание архива на локальную машину
ssh user@192.168.31.83 "rm /tmp/backup_$(date +%F).tar.gz"  # Удаление архива на удалённом сервере
ssh user@192.168.31.83 "mkdir -p /home/user/MS_Lebedeva/extracted && tar -xzf /tmp/backup_$(date +%F).tar.gz -C /home/user/MS_Lebedeva/extracted"  # Разархивация на удалённом сервере
