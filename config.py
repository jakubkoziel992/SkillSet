import os

class Config: 
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'mysql+mysqlconnector://root:admin@127.0.0.1/skill_set')
    SQLALCHEMY_TRACK_MODIFICATIONS = False