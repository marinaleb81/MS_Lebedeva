# Переменные
REMOTE_SERVER="user@192.168.31.83"
REMOTE_DIR="/home/user/MS_Lebedeva/"
LOCAL_DIR="e:/Вэб инжениринг/Задачи на уроке SSH/backup"


# Синхронизация файлов (Скриптом)
rsync -avz --delete $LOCAL_DIR/ $REMOTE_SERVER:$REMOTE_DIR/

# Синхронизация файлов (локальные файлы -> сервер) в PowerShell
rsync -avz --delete "e:/Вэб инжениринг/Задачи на уроке SSH/backup/" user@192.168.31.83:/home/user/MS_Lebedeva/


# Обратная синхронизация (с сервера на локальную машину) (Скриптом)
rsync -avz --delete $REMOTE_SERVER:$REMOTE_DIR/ $LOCAL_DIR/

# Обратная синхронизация файлов (сервер -> локальная машина)  в PowerShell
rsync -avz --delete user@192.168.31.83:/home/user/MS_Lebedeva/ "e:/Вэб инжениринг/Задачи на уроке SSH/backup/"