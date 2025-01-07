from flask import Flask
from database import db
from config import Config
from routes import blueprint
from schemas import ma

app = Flask(__name__)

app.config.from_object(Config)

db.init_app(app)
ma.init_app(app)

app.register_blueprint(blueprint)
 
if __name__ == "__main__":
    app.run(debug=True)