from flask import Blueprint, request, jsonify, render_template
from models import Course, Author
from schemas import CourseSchema, AuthorSchema
import services
import socket

blueprint = Blueprint('api', __name__)


@blueprint.route('/health', methods=['GET'])
def health_check():
    return jsonify({ 'msg': 'OK'})  

@blueprint.route('/info', methods=['GET'])
def get_info():
    return jsonify(hostname=socket.gethostname())

@blueprint.route('/')
def home():
    return render_template('base.html')
    
@blueprint.route('/course', methods=['GET'])
def get_courses():
    courses = services.get_all_courses()
    return render_template('index.html', courses=courses)

@blueprint.route('/course', methods=['POST'])
def add_course():    
    data = request.json
    return jsonify(services.create_course(data))
    

@blueprint.route('/course/<int:id>/', methods=['PATCH'])
def update_course(id):
    data = request.json    
    return jsonify(services.update_course(data,id)) 


@blueprint.route('/course/<int:id>/', methods=['DELETE'])
def delete_course(id):
    return jsonify(services.delete_course(id))


@blueprint.route('/author', methods=['GET'])
def get_authors():
    authors = services.get_all_authors()
    return render_template('authors.html', authors=authors)

@blueprint.route('/author', methods=['POST'])
def add_author():
    name = request.json['name']
    return jsonify(services.create_author(name))


@blueprint.route('/author/<int:id>/', methods=['PUT'])
def update_author(id):
    name = request.json['name']    
    return jsonify(services.update_author(name, id))


@blueprint.route('/author/<int:id>/', methods=['DELETE'])
def delete_author(id):
    return jsonify(services.delete_author(id))