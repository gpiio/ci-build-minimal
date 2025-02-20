from fastapi.testclient import fastapi
from ..main import app

client = fastapi.TestClient(app)

def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_health_check_response_time():
    response = client.get("/health")
    assert response.elapsed.total_seconds() < 1  # Should respond under 1 second

def test_invalid_route():
    response = client.get("/invalid")
    assert response.status_code == 404
