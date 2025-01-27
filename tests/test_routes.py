import socket

def test_health_check(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json == {'msg': 'OK'}


def test_get_info(client):
    response = client.get('/info')
    assert response.status_code == 200
    assert response.json['hostname'] == socket.gethostname()