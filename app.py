from flask import Flask, request, jsonify
from database import db
from models import Course, Author
from schemas import ma, courses_schema, author_schema, authors_schema


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


@app.route('/course', methods=['GET'])
def get_courses():
    courses = Course.query.all()  
    
    return jsonify(courses_schema.dump(courses))

@app.route('/author', methods=['GET'])
def get_authors():
    authors = Author.query.all()
    
    return jsonify(authors_schema.dump(authors))
 
if __name__ == "__main__":
    app.run(debug=True)