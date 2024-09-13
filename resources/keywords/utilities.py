import os
from datetime import datetime

def get_day_from_string(date_string):
    # Parse the date string
    date_object = datetime.strptime(date_string, '%d %B %Y')
    # Return the day as an integer
    return date_object.day

def get_month_from_string(date_string):
    # Parse the date string
    date_object = datetime.strptime(date_string, '%d %B %Y')
    # Return the month as a string
    return date_object.strftime('%B')

def get_year_from_string(date_string):
    # Parse the date string
    date_object = datetime.strptime(date_string, '%d %B %Y')
    # Return the year as an integer
    return date_object.year

def normalize_path(path):
    return os.path.abspath(path)