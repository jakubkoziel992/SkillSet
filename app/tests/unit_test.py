import pytest
from unittest.mock import patch, MagicMock
from services import create_author, create_course, delete_course, update_author
from models import Author, Course
from datetime import date

def test_create_author_when_not_exists(mock_db_session):
    with patch('services.Author.query') as mock_query:
        mock_query.filter_by.return_value.first.return_value = None

        result = create_author("Liam Johnson")

        assert result["name"] == "Liam Johnson"
        mock_db_session.add.assert_called_once()
        mock_db_session.commit.assert_called_once()

def test_create_author_when_exists(mock_db_session):
    with patch('services.Author.query') as mock_query:
        mock_query.filter_by.return_value.first.return_value = Author("Isabella Cooper")

        result = create_author("Isabella Cooper")

        assert "error" in result
        mock_db_session.add.assert_not_called()
        mock_db_session.commit.assert_not_called()

from unittest.mock import patch, MagicMock
from datetime import date
from services import create_course
from models import Author


def test_create_course_existing_author(mock_db_session):
    with patch('services.Author.query') as mock_author_query, \
         patch('services.Course') as mock_course_model, \
         patch('services.course_schema') as mock_course_schema:

        mock_author = Author("Mock Author")
        mock_author.id = 1
        mock_author_query.filter_by.return_value.first.return_value = mock_author

        mock_course_instance = MagicMock()
        mock_course_model.return_value = mock_course_instance

        mock_course_schema.dump.return_value = {
            "name": "Python 101",
            "author_name": "Mock Author",
            "platform": "Udemy",
            "completion_date": "2024-01-01"
        }
        result = create_course("Python 101", "Mock Author", "Udemy", date(2024, 1, 1))
        assert result["name"] == "Python 101"
        mock_db_session.add.assert_called_once_with(mock_course_instance)
        mock_db_session.commit.assert_called_once()


def test_delete_course_found(mock_db_session):
    with patch('services.Course.query') as mock_query:
        mock_course = Course("Course to Delete", 1, "Udemy", None)
        mock_query.get.return_value = mock_course

        result = delete_course(42)

        assert result == {"msg": "Usunięto kurs"}
        mock_db_session.delete.assert_called_once_with(mock_course)
        mock_db_session.commit.assert_called_once()

def test_delete_course_not_found(mock_db_session):
    with patch('services.Course.query') as mock_query:
        mock_query.get.return_value = None

        result = delete_course(99)

        assert result == {"error": "course nie został znaleziony"}
        mock_db_session.delete.assert_not_called()
        mock_db_session.commit.assert_not_called()


def test_update_author_success(mock_db_session):
    with patch('services.Author.query') as mock_query:
        mock_author = Author("Old Name")
        mock_query.get.return_value = mock_author

        result = update_author("New Name", 1)

        assert result["name"] == "New Name"
        assert mock_author.name == "New Name"
        mock_db_session.commit.assert_called_once()