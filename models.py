from flask_marshmallow import Marshmallow
from database import db

ma = Marshmallow()

class Course(db.Model):
    __tablename__ = 'course'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    author_id = db.Column(db.Integer, nullable=False)
    platform = db.Column(db.String(100))
    completion_date = db.Column(db.Date)
    
    # def __init__(self, name, author_id, platform, completion_date):
    #     self.name = name
    #     self.author_id = author_id
    #     self.platform = platform
    #     self.completion_date = completion_date

# Course schema
class CourseSchema(ma.Schema):
    class Meta:
        fields = ('id', 'name', 'author_id', 'platform', 'completion_date')
        
#Init schema
course_schema = CourseSchema()
courses_schema = CourseSchema(many=True)