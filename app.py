from flask import Flask, request, jsonify
from database import db
from models import ma, Course, courses_schema


#Init app
app = Flask(__name__)

# db
DATABASE_URL = 'mysql+mysqlconnector://root:admin@127.0.0.1/skill_set'
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)
ma.init_app(app)


@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({ 'msg': 'OK'})  


@app.route('/course')
def get_courses():
    courses = Course.query.all()  
    result = courses_schema.dump(courses)
    
    return jsonify(result)

 
if __name__ == "__main__":
    app.run(debug=True)