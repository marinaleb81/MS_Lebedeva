# Синхронизация локальной директории с удалённой (из локальной в удалённую)
rsync -avz --exclude-from="e:/Вэб инжениринг/Задачи на уроке SSH/backup/.rsync-exclude" "e:/Вэб инжениринг/Задачи на уроке SSH/backup/" user@192.168.31.83:/home/user/MS_Lebedeva/

# Синхронизация удалённой директории с локальной (из удалённой в локальную)
rsync -avz --exclude-from="e:/Вэб инжениринг/Задачи на уроке SSH/backup/.rsync-exclude" user@192.168.31.83:/home/user/MS_Lebedeva/ "e:/Вэб инжениринг/Задачи на уроке SSH/backup/"

# Для тестового запуска (без реальной синхронизации)
rsync -avz --dry-run --exclude-from="e:/Вэб инжениринг/Задачи на уроке SSH/backup/.rsync-exclude" "e:/Вэб инжениринг/Задачи на уроке SSH/backup/" user@192.168.31.83:/home/user/MS_Lebedeva/

