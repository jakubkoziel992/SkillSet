from flask_wtf import FlaskForm
from wtforms import StringField, DateField, SelectField, SubmitField
from wtforms.validators import DataRequired

class CourseForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    author_name = StringField('Author', validators=[DataRequired()])
    platform = StringField('Platform')
    completion_date = DateField('Completion Date', format='%Y-%m-%d')
    submit = SubmitField('Add')
    
class AuthorForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])

