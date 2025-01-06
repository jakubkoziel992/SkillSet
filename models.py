from database import db



class Course(db.Model):
    __tablename__ = 'course'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('author.id'), nullable=False)
    platform = db.Column(db.String(100))
    completion_date = db.Column(db.Date)
    
    author = db.relationship('Author', back_populates='courses')
    
    
    
    # def __init__(self, name, author_id, platform, completion_date):
    #     self.name = name
    #     self.author_id = author_id
    #     self.platform = platform
    #     self.completion_date = completion_date
    
class Author(db.Model):
    __tablename__ = 'author'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(150), nullable=False)
    
    courses = db.relationship('Course', back_populates='author')
    

