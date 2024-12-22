import requests

# Адрес вашего API
API_URL = "http://127.0.0.1:5000/items"

# Список забавных задач
fun_tasks = [
    {
        "title": "Устроить пикник для своего плюшевого медведя",
        "description": "Собрать корзинку с любимыми игрушками и отправиться на воображаемую прогулку.",
        "completed": False
    },
    {
        "title": "Научить кота новым трюкам",
        "description": "Пытаться научить своего кота сидеть или приносить тапочки (без гарантии успеха).",
        "completed": False
    },
    {
        "title": "Провести переговоры с холодильником",
        "description": "Достичь соглашения о том, чтобы не открывать его ночью.",
        "completed": False
    },
    {
        "title": "Организовать танцевальный вечер с растениями",
        "description": "Включить музыку и танцевать вместе с вашими домашними растениями.",
        "completed": False
    },
    {
        "title": "Составить список способов избежать утреннего подъёма",
        "description": "Включить идеи вроде 'проспать до обеда' или 'убежать в другую реальность'.",
        "completed": False
    },
    {
        "title": "Почитать книгу наоборот",
        "description": "Начать с последней страницы и двигаться к началу.",
        "completed": False
    },
    {
        "title": "Создать шедевр из макарон и сыра",
        "description": "Попробовать построить что-то необычное из макаронных изделий и сыра.",
        "completed": False
    },
    {
        "title": "Организовать конкурс 'Кто быстрее засыпит на рабочем месте'",
        "description": "Провести забавное соревнование с коллегами или друзьями.",
        "completed": False
    },
    {
        "title": "Придумать новый язык для общения с домашними животными",
        "description": "Создать уникальные звуки и команды для своего питомца.",
        "completed": False
    },
    {
        "title": "Провести день без интернета и записать свои впечатления",
        "description": "Попробовать жить без современных технологий и документировать свои чувства.",
        "completed": False
    },
    # Добавьте остальные задачи по аналогии
]

def add_tasks(api_url, tasks):
    for task in tasks:
        response = requests.post(api_url, json=task)
        if response.status_code in [200, 201]:
            print(f"Задача '{task['title']}' успешно добавлена.")
        else:
            print(f"Ошибка при добавлении задачи '{task['title']}': {response.text}")

if __name__ == "__main__":
    add_tasks(API_URL, fun_tasks)