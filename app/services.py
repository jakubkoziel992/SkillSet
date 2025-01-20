from models import Course, Author
from schemas import CourseSchema, AuthorSchema
from database import db

courses_schema = CourseSchema(many=True)
course_schema = CourseSchema()
authors_schema = AuthorSchema(many=True)
author_schema = AuthorSchema()


def resource_not_found(resource_name):
    return {"error": f"{resource_name} nie został znaleziony"}

def get_author_by_id(id):
    author = Author.query.get(id)
    if not author:
        return None
    return author

def get_course_by_id(id):
    course = Course.query.get(id)
    if not course:
        return None
    return course


def get_or_create_author(author_name):
    author = Author.query.filter_by(name=author_name).first()
    if not author:
        new_author = Author(author_name)
        db.session.add(new_author)
        db.session.commit()
        
        return new_author
    
    return author

def get_all_courses():
    courses = Course.query.all()  
    return courses_schema.dump(courses)


def create_course(name, author_name, platform, completion_date):
    print(author_name)
    author = get_or_create_author(author_name)
    print(author.id)
    
    author_id = author.id    
    course = Course(name, author_id, platform, completion_date)
    db.session.add(course)
    db.session.commit()
    
    return course_schema.dump(course)


def update_course(name, author_name, platform, completion_date, id):
    course = Course.query.get(id)
    if not course:
        return resource_not_found('course')
    
    author = get_or_create_author(author_name)
    
    course.name = name
    course.author_id = author.id
    course.platform = platform
    course.completion_date = completion_date

    db.session.commit()
    return course_schema.dump(course)

def delete_course(id):
    course = Course.query.get(id)
    
    if not course:
        return resource_not_found('course')
    
    db.session.delete(course)
    db.session.commit()
    return {"msg": f"Usunięto kurs"}


def get_all_authors():
    authors = Author.query.all()
    return authors_schema.dump(authors) 

def create_author(name): 
    author = Author.query.filter_by(name=name).first()
    
    if not author:
        new_author = Author(name)
        db.session.add(new_author)
        db.session.commit()
        
        return author_schema.dump(new_author)
    
    return {"error": f"Istnieje już autor o nazwe {name}"}

def update_author(name, id):
    author = Author.query.get(id)
    if not author:
        return resource_not_found('author')
    
    author.name = name
    db.session.commit()
    
    return author_schema.dump(author)

def delete_author(id):
    author = Author.query.get(id)
    
    if not author:
        return resource_not_found('author')
    
    db.session.delete(author)
    db.session.commit()
    return {"msg": f"Usunięto autora"}
    