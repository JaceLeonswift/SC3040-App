from django.apps import AppConfig
import json
import os

cache = {}

def save_cache_to_file(filename='show_cache.json'):
    global cache
    with open(filename, 'w') as f:
        json.dump(cache, f)
        print(cache, "\nCache saved")

def load_cache_from_file(filename='show_cache.json'):
    global cache
    # Check if the file exists and has content
    if os.path.exists(filename) and os.path.getsize(filename) > 0:
        with open(filename, 'r') as f:
            cache = json.load(f)
            # Assert that cache is a dictionary
            assert isinstance(cache, dict), f"Expected cache to be a dict, but got {type(cache)}"
            print(cache, "\nCache loaded")
    else:
        print(f"Cache file '{filename}' not found.")


class Sc3040DatabaseConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "SC3040_database"
    def ready(self):
        global cache
        load_cache_from_file()
