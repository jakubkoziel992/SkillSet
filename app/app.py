from flask import Flask
from database import db
from config import DevelopmentConfig, ProductionConfig, TestConfig
from routes import blueprint
from schemas import ma
from os import environ, getenv

# env = getenv("FLASK_ENV", "dev")
env = environ.get("FLASK_ENV", "dev")

if env == "prod":
    config = ProductionConfig()
elif env == "test":
    config = TestConfig()
else:
    config = DevelopmentConfig()


app = Flask(__name__)

app.config.from_object(config)
app.config['SECRET_KEY'] = getenv('SECRET_KEY')

db.init_app(app)
ma.init_app(app)

app.register_blueprint(blueprint)
 
if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(host='0.0.0.0')
