from flask_marshmallow import Marshmallow
from marshmallow import fields

ma = Marshmallow()

class AuthorSchema(ma.Schema):
    class Meta:
        fields = ('id', 'name')
    
    courses = fields.Nested('CourseSchema', many=True)

class CourseSchema(ma.Schema):
    class Meta:
        fields = ('id', 'name', 'author_id', 'platform', 'completion_date')
    
    author = fields.Nested(AuthorSchema)




course_schema = CourseSchema()
courses_schema = CourseSchema(many=True)

author_schema = AuthorSchema()
authors_schema = AuthorSchema(many=True)