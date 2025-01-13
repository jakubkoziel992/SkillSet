from flask import Blueprint, request, jsonify, render_template, redirect, url_for
from models import Course, Author
from schemas import CourseSchema, AuthorSchema
from forms import CourseForm, AuthorForm
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
    form = CourseForm()

    if form.validate_on_submit():
        name = form.name.data
        author_name = form.author_name.data
        platform = form.platform.data
        completion_date = form.completion_date.data
        
        services.create_course(name, author_name, platform, completion_date)
        return redirect(url_for('api.get_courses'))
    
    return render_template('manage_course.html', form=form)

@blueprint.route('/course/edit/<int:id>/', methods=['GET','POST','PATCH'])
def update_course(id):
    course = services.get_course_by_id(id)
    form = CourseForm(obj=course)
    
    if request.method == 'POST' and  request.form.get("_method") == "PATCH"  and form.validate_on_submit():
        name = form.name.data
        author_name = form.author_name.data
        platform = form.platform.data
        completion_date = form.completion_date.data
        
        services.update_course(name, author_name, platform, completion_date, id)
        return redirect(url_for('api.get_courses'))
    
    print(form.errors)
    return render_template('manage_course.html', form=form, edit=True, id=id)


@blueprint.route('/course/<int:id>/', methods=['POST'])
def delete_course(id):    
    if request.form.get("_method") == "DELETE":
        services.delete_course(id)
        return redirect(url_for('api.get_courses'))


@blueprint.route('/author', methods=['GET'])
def get_authors():
    authors = services.get_all_authors()
    return render_template('authors.html', authors=authors)

@blueprint.route('/author', methods=['POST'])
def add_author():
    form = AuthorForm()
    name = form.name.data
    
    if form.validate_on_submit():
        services.create_author(name)
        return redirect(url_for('api.get_authors'))

    return render_template('manage_author.html', form=form, edit=False)

@blueprint.route('/author/edit/<int:id>/', methods=['GET', 'POST', 'PUT'])
def update_author(id):
    author = services.get_author_by_id(id)
    form = AuthorForm(obj=author)
    
    if request.method == 'POST' and request.form.get("_method") == "PUT"  and form.validate_on_submit():
        name = form.name.data
        services.update_author(name, id)
        return redirect(url_for('api.get_authors'))
        
    return render_template('manage_author.html', form=form, id=id, edit=True)


@blueprint.route('/author/<int:id>/', methods=['POST', 'DELETE'])
def delete_author(id):
    if request.method == 'POST' and request.form.get("_method") == "DELETE":
        services.delete_author(id)
        return redirect(url_for('api.get_authors'))