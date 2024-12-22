from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_create_item():
    response = client.post(
        "/items",
        headers={"Authorization": "Bearer supersecrettoken"},
        json={"title": "Test Task", "description": "Test Description", "completed": False},
    )
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Test Task"
    assert data["description"] == "Test Description"
    assert data["completed"] is False

def test_get_items():
    response = client.get("/items", headers={"Authorization": "Bearer supersecrettoken"})
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)

def test_get_item_by_id():
    response = client.post(
        "/items",
        headers={"Authorization": "Bearer supersecrettoken"},
        json={"title": "Another Task", "description": "Another Description", "completed": True},
    )
    item_id = response.json()["id"]
    response = client.get(f"/items/{item_id}", headers={"Authorization": "Bearer supersecrettoken"})
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Another Task"

def test_filter_items_by_status():
    client.post(
        "/items",
        headers={"Authorization": "Bearer supersecrettoken"},
        json={"title": "Completed Task", "description": "Completed Description", "completed": True},
    )
    response = client.get("/items?completed=true", headers={"Authorization": "Bearer supersecrettoken"})
    assert response.status_code == 200
    data = response.json()
    assert all(item["completed"] for item in data)
