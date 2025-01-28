from flask import Flask
from database import db
from config import DevelopmentConfig, ProductionConfig
from routes import blueprint
from schemas import ma
from os import environ,getenv


def create_app(config_name=None):
    app = Flask(__name__)

    if not config_name:
        env = environ.get("FLASK_ENV", "dev")
        if env == "prod":
            config_name = ProductionConfig()
        elif env == "test":
            config_name = TestingConfig()
        else:
            config_name = DevelopmentConfig()

    app.config.from_object(config_name)
    app.config['SECRET_KEY'] = getenv('SECRET_KEY')

    db.init_app(app)
    ma.init_app(app)

    app.register_blueprint(blueprint)

    return app

if __name__ == "__main__":
    app = create_app()
    with app.app_context():
        db.create_all()
    app.run(host='0.0.0.0')