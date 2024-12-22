# main.py
from typing import List, Optional
from fastapi import FastAPI, HTTPException, Depends, Form, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session
from sqlalchemy import desc, or_
from database import SessionLocal, engine, Base
from models import TodoItem as TodoItemModel
from pydantic import BaseModel
from datetime import datetime

# Создание всех таблиц в базе данных
Base.metadata.create_all(bind=engine)

app = FastAPI()

# Настройка шаблонов
templates = Jinja2Templates(directory="templates")

# Pydantic модели
class TodoCreate(BaseModel):
    title: str
    description: Optional[str] = None
    completed: bool = False

class TodoResponse(BaseModel):
    id: int
    title: str
    description: Optional[str] = None
    completed: bool = False
    created_at: datetime  # Новое поле

    class Config:
        orm_mode = True

# Зависимость для получения сессии базы данных
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Главная страница с веб-интерфейсом
@app.get("/", response_class=HTMLResponse)
def read_root(request: Request, db: Session = Depends(get_db)):
    # Сортировка задач по убыванию ID
    tasks = db.query(TodoItemModel).order_by(desc(TodoItemModel.id)).all()
    return templates.TemplateResponse("index.html", {"request": request, "tasks": tasks})

# Маршрут для создания новой задачи через форму
@app.post("/add", response_class=RedirectResponse)
def add_task(
    request: Request,
    title: str = Form(...),
    description: str = Form(...),
    db: Session = Depends(get_db)
):
    new_task = TodoItemModel(title=title, description=description, completed=False)
    db.add(new_task)
    db.commit()
    db.refresh(new_task)
    return RedirectResponse(url="/", status_code=303)

# Маршрут для редактирования задачи: отображение формы
@app.get("/edit/{item_id}", response_class=HTMLResponse)
def edit_task(request: Request, item_id: int, db: Session = Depends(get_db)):
    task = db.query(TodoItemModel).filter(TodoItemModel.id == item_id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return templates.TemplateResponse("edit.html", {"request": request, "task": task})

# Маршрут для обработки формы редактирования задачи
@app.post("/edit/{item_id}", response_class=RedirectResponse)
def update_task(
    request: Request,
    item_id: int,
    title: str = Form(...),
    description: str = Form(...),
    completed: Optional[bool] = Form(False),
    db: Session = Depends(get_db)
):
    task = db.query(TodoItemModel).filter(TodoItemModel.id == item_id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    task.title = title
    task.description = description
    task.completed = completed
    db.commit()
    db.refresh(task)
    return RedirectResponse(url="/", status_code=303)

# Маршрут поиска задач по ключевым словам
@app.get("/search", response_class=HTMLResponse)
def search_tasks(request: Request, query: str, db: Session = Depends(get_db)):
    # Используем ilike для регистронезависимого поиска
    search_query = f"%{query}%"
    search_results = db.query(TodoItemModel).filter(
        or_(
            TodoItemModel.title.ilike(search_query),
            TodoItemModel.description.ilike(search_query)
        )
    ).order_by(desc(TodoItemModel.id)).all()
    return templates.TemplateResponse("index.html", {
        "request": request,
        "tasks": db.query(TodoItemModel).order_by(desc(TodoItemModel.id)).all(),
        "search_results": search_results,
        "search_query": query
    })

# API маршруты остаются для работы с фронтендом через AJAX или другими методами

# Маршрут получения всех задач через API
@app.get("/items", response_model=List[TodoResponse])
def get_items_api(db: Session = Depends(get_db)):
    # Сортировка задач по убыванию ID
    items = db.query(TodoItemModel).order_by(desc(TodoItemModel.id)).all()
    return items

# Маршрут получения одной задачи по ID через API
@app.get("/items/{item_id}", response_model=TodoResponse)
def get_item_api(item_id: int, db: Session = Depends(get_db)):
    item = db.query(TodoItemModel).filter(TodoItemModel.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    return item

# Маршрут создания новой задачи через API
@app.post("/items", response_model=TodoResponse)
def create_item_api(item: TodoCreate, db: Session = Depends(get_db)):
    new_item = TodoItemModel(
        title=item.title,
        description=item.description,
        completed=item.completed
    )
    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    return new_item

# Маршрут обновления существующей задачи через API
@app.put("/items/{item_id}", response_model=TodoResponse)
def update_item_api(item_id: int, item: TodoCreate, db: Session = Depends(get_db)):
    db_item = db.query(TodoItemModel).filter(TodoItemModel.id == item_id).first()
    if not db_item:
        raise HTTPException(status_code=404, detail="Item not found")
    db_item.title = item.title
    db_item.description = item.description
    db_item.completed = item.completed
    db.commit()
    db.refresh(db_item)
    return db_item

# Маршрут удаления задачи через API
@app.delete("/items/{item_id}")
def delete_item_api(item_id: int, db: Session = Depends(get_db)):
    db_item = db.query(TodoItemModel).filter(TodoItemModel.id == item_id).first()
    if not db_item:
        raise HTTPException(status_code=404, detail="Item not found")
    db.delete(db_item)
    db.commit()
    return {"message": "Item deleted"}
