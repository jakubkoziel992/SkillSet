from flask import Flask
from database import db
from config import DevelopmentConfig, ProductionConfig
from routes import blueprint
from schemas import ma
from os import environ, getenv

# env = getenv("FLASK_ENV", "dev")
env = environ.get("FLASK_ENV", "dev")

if env == "prod":
    config = ProductionConfig()
else:
    config = DevelopmentConfig()


app = Flask(__name__)

app.config.from_object(config)


db.init_app(app)
ma.init_app(app)

app.register_blueprint(blueprint)
 
if __name__ == "__main__":
    app.run()