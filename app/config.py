import os

class Config: 
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'mysql+mysqlconnector://root:admin@127.0.0.1/skill_set')
    
class TestConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')
    
    if SQLALCHEMY_DATABASE_URI is None:
        SQLALCHEMY_DATABASE_URI = (
            "mysql+mysqlconnector://"
            + os.environ.get("DB_USER", "")
            + ":"
            + os.environ.get("DB_PASSWORD", "")
            + "@"
            + os.environ.get("DB_HOST", "")
            + "/"
            + os.environ.get("DB_NAME", "")
        )    


class ProductionConfig(Config):
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL')
    
    if SQLALCHEMY_DATABASE_URI is None:
        SQLALCHEMY_DATABASE_URI = (
            "mysql+mysqlconnector://"
            + os.environ.get("DB_USER", "")
            + ":"
            + os.environ.get("DB_PASSWORD", "")
            + "@"
            + os.environ.get("DB_HOST", "")
            + "/"
            + os.environ.get("DB_NAME", "")
        )


    
    
# config_dict = {
#     "dev" : DevelopmentConfig,
#     "prod" : ProductionConfig
# }