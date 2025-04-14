import socket
from services import create_course,create_author
from datetime import date

def test_health_check(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json == {'msg': 'OK'}


def test_get_info(client):
    response = client.get('/info')
    assert response.status_code == 200
    assert response.json['hostname'] == socket.gethostname()
    

def test_get_course(client,init_db):
    create_course("Python", "Author 1", "Udemy", date(2025,1,28))
    
    response = client.get('/course')
    assert response.status_code == 200
    assert b"Python" in response.data
    
def test_get_authors(client, init_db):
    create_author("Jan Kowalski")
    
    response = client.get('/author')
    assert response.status_code == 200
    assert b"Jan Kowalski" in response.data