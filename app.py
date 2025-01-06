from flask import Flask, request, jsonify
from database import db
from models import Course, Author
from schemas import ma, CourseSchema, AuthorSchema


#Init app
app = Flask(__name__)

# db
DATABASE_URL = 'mysql+mysqlconnector://root:admin@127.0.0.1/skill_set'
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)
ma.init_app(app)

def resource_not_found(resource_name):
    return jsonify({"error": f"{resource_name} nie został znaleziony"}), 404


@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({ 'msg': 'OK'})  


@app.route('/course', methods=['GET'])
def get_courses():
    courses_schema = CourseSchema(many=True)
    courses = Course.query.all()  
    
    return jsonify(courses_schema.dump(courses))

@app.route('/course', methods=['POST'])
def add_course():
    course_input_schema = CourseSchema()
    
    data = request.json
    
    name = data['name']
    author_id = data['author_id']
    platform = data['platform']
    completion_date = data['completion_date']

    author = Author.query.filter_by(id=author_id).first()
    
    if author:
        course = Course(name, author_id, platform, completion_date)
        db.session.add(course)
        db.session.commit()
        
        return jsonify(course_input_schema.dump(course))
    
    return resource_not_found('author')

@app.route('/course/<int:id>/', methods=['PATCH'])
def update_course(id):
    course_schema = CourseSchema()
    
    course = Course.query.get(id)
    
    if not course:
        return resource_not_found('course')
    
    data = request.json
    
    if 'name' in data:
        course.name = data['name']
    elif 'author_id' in data:
        course.author_id = data['author_id']
    elif 'platform' in data:
        course.platform = data['platform']
    elif 'completion_date' in data:
        course.completion_date = data['completion_date']
    
    db.session.commit()
    
    return jsonify(course_schema.dump(course)) 


@app.route('/course/<int:id>/', methods=['DELETE'])
def delete_course(id):
    course_schema = CourseSchema()
    course = Course.query.get(id)
    
    if not course:
        return resource_not_found('course')
    
    db.session.delete(course)
    db.session.commit()
    
    return jsonify(course_schema.dump(course))


@app.route('/author', methods=['GET'])
def get_authors():
    authors_schema = AuthorSchema(many=True)
    authors = Author.query.all()
    
    return jsonify(authors_schema.dump(authors))


@app.route('/author', methods=['POST'])
def add_author():
    author_input_schema = AuthorSchema()
    
    name = request.json['name']
    
    author = Author.query.filter_by(name=name).first()
    
    if not author:
        new_author = Author(name)
        db.session.add(new_author)
        db.session.commit()
        
        return jsonify(author_input_schema.dump(new_author))

    return jsonify({"error": f"Istnieje już autor o nazwe {author}"}), 404


@app.route('/author/<int:id>/', methods=['PUT'])
def update_author(id):
    author_schema = AuthorSchema()
    author = Author.query.get(id)
    
    if not author:
        return resource_not_found('author')
    
    name = request.json['name']
    author.name = name
    
    db.session.commit()
    
    return jsonify(author_schema.dump(author))


@app.route('/author/<int:id>/', methods=['DELETE'])
def delete_author(id):
    author_schema = AuthorSchema()
    author = Author.query.get(id)
    
    if not author:
        return resource_not_found('author')
    
    db.session.delete(author)
    db.session.commit()
    
    return jsonify(author_schema.dump(author))
    
if __name__ == "__main__":
    app.run(debug=True)