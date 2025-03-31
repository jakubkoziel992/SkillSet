import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../app')))

import pytest
from app import create_app
from database import db
from config import TestingConfig

@pytest.fixture(scope='module')
def app():
    flask_app = create_app(TestingConfig)   
    with flask_app.app_context():
        yield flask_app

@pytest.fixture(scope='module')
def client(app):
    return app.test_client()

@pytest.fixture(scope='module')
def init_db():
    db.create_all()
    yield db
    db.drop_all()