from flask_marshmallow import Marshmallow
from marshmallow import fields

ma = Marshmallow()

class AuthorSchema(ma.Schema):
    class Meta:
        fields = ('id', 'name', 'courses')
    
    # courses = fields.Pluck('CourseSchema', 'name', many=True)
    courses = fields.Function(lambda obj: [course.name for course in obj.courses])


class CourseSchema(ma.Schema):
    class Meta:
        fields = ('id', 'name', 'author_id', 'platform', 'completion_date', 'author_name' )
    
    # author_name = fields.Nested(AuthorSchema)
    author_name = fields.Function(lambda obj: obj.author.name if obj.author else None)
