from django.urls import path
from .views import verify_login, create_account, update_password, delete_account, create_collection_of_shows, rename_collection_of_shows, save_show_to_collection, delete_shows_from_collection, delete_collections, post_review, delete_reviews, edit_review, get_reviews_for_show, get_recommended_shows, get_text_vector

urlpatterns = [
    path('verify_login/', verify_login, name='verify_login'),
    path('create_account/', create_account, name='create_account'),
    path('update_password/', update_password, name='update_password'),
    path('delete_account/', delete_account, name='delete_account'),
    path('create_collection_of_shows/', create_collection_of_shows, name='create_collection_of_shows'),
    path('rename_collection_of_shows/', rename_collection_of_shows, name='rename_collection_of_shows'),
    path('save_show_to_collection/', save_show_to_collection, name='save_show_to_collection'),
    path('delete_shows_from_collection/', delete_shows_from_collection, name='delete_shows_from_collection'),
    path('delete_collections/', delete_collections, name='delete_collections'),
    path('post_review/', post_review, name='post_review'),
    path('delete_reviews/', delete_reviews, name='delete_reviews'),
    path('edit_review/', edit_review, name='edit_review'),
    path('get_reviews_for_show/', get_reviews_for_show, name='get_reviews_for_show'),
    path('get_recommended_shows/', get_recommended_shows, name='get_recommended_shows'),
    path('get_text_vector/', get_text_vector, name='get_text_vector'),
]
