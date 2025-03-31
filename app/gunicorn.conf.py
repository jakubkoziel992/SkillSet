wsgi_app = "app:create_app()"
bind = "0.0.0.0:8000"
accesslog = "-"
loglevel = "info"
workers = "2"
capture_output = True
