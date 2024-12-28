from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .db import users_collection
import bcrypt
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
import requests
from django.conf import settings
from .apps import cache, save_cache_to_file
from hdbscan import HDBSCAN, approximate_predict

# Global dictionary to hold HDBSCAN objects for each user by username
HDBSCAN_CLUSTERER_dict = {}

# Helper function to generate JWT tokens without using Django's User model
def get_tokens_for_custom_user(user):
    # Manually create the refresh token
    refresh = RefreshToken()
    # Adding custom claims (username)
    refresh['user_id'] = str(user['_id'])
    # Return both access and refresh tokens
    return {'refresh': str(refresh), 'access': str(refresh.access_token)}

@csrf_exempt
@api_view(['GET'])
@permission_classes([AllowAny])
def verify_login(request):
    username = request.GET['username']
    password = request.GET['password']

    if not username or not password:
        return JsonResponse({"message": "Username and password cannot be blank"}, status=400)

    try:
        user = users_collection.find_one({'username': username})
        if user:
            # Check if the provided password matches the hashed password in the database
            stored_hashed_password = user['password']
            if bcrypt.checkpw(password.encode('utf-8'), stored_hashed_password.encode('utf-8')):
                user['_id'] = str(user['_id'])  # Convert ObjectId to string
                # Generate JWT tokens
                tokens = get_tokens_for_custom_user(user)
                return JsonResponse({"message": "Login successful", "user": user, "tokens": tokens}, status=200)
            else:
                return JsonResponse({"message": "Wrong Username or Password"}, status=401)
        else:
            return JsonResponse({"message": "Wrong Username or Password"}, status=401)
    except Exception as e:
        return JsonResponse({"message": f"Error verifying login: {e}"}, status=500)

    
@csrf_exempt
@api_view(['POST'])
@permission_classes([AllowAny])
def create_account(request):
    body = request.data
    username = body['username']
    password = body['password']

    if not username or not password:
        return JsonResponse({"message": "Username and password cannot be blank"}, status=400)

    try:
        # Check if the username already exists
        existing_user = users_collection.find_one({'username': username})
        if existing_user:
            return JsonResponse({"message": "Username already exists"}, status=400)

        # Insert the new user
        result = users_collection.insert_one({'username': username,'password': bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8'),'shows_collections_list': [],'reviews_list': [], 'favourite_shows': [], 'data_matrix': [], 'recommended_shows': []})

        if result.inserted_id:
            return JsonResponse({"message": f"Account created successfully for username: {username}"}, status=201)
        else:
            return JsonResponse({"message": "Failed to create account"}, status=500)
    except Exception as e:
        return JsonResponse({"message": f"Error creating account: {e}"}, status=500)
    

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def update_password(request):
    body = request.data
    username = body['username']
    old_password = body['old_password']
    new_password = body['new_password']

    if not username or not old_password or not new_password:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Check if the old password matches the stored hash
            stored_hashed_password = user['password']
            
            if bcrypt.checkpw(old_password.encode('utf-8'), stored_hashed_password.encode('utf-8')):
                # Hash the new password
                user['password'] = bcrypt.hashpw(new_password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

                # Update the user's password in the database
                result = users_collection.update_one(
                    {'username': username},
                    {'$set': {'password': user['password']}}
                )

                if result.matched_count:
                    user['_id'] = str(user['_id'])  # Convert ObjectId to string
                    return JsonResponse({"message": f"Password updated successfully for username: {username}", "user": user}, status=200)
                else:
                    return JsonResponse({"message": "Failed to update password"}, status=500)
            else:
                return JsonResponse({"message": "Wrong old password"}, status=401)
        else:
            return JsonResponse({"message": "Wrong username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error updating password: {e}"}, status=500)

    
@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def delete_account(request):
    body = request.data
    username = body['username']
    password = body['password']

    if not username or not password:
        return JsonResponse({"message": "Username and password cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Check if the password matches the stored hash
            stored_hashed_password = user['password']
            
            if bcrypt.checkpw(password.encode('utf-8'), stored_hashed_password.encode('utf-8')):
                # Delete the user
                result = users_collection.delete_one({'username': username})

                if result.deleted_count:
                    # Also delete the entry from HDBSCAN_CLUSTERER_dict for this user
                    if username in HDBSCAN_CLUSTERER_dict:
                        del HDBSCAN_CLUSTERER_dict[username]
                    return JsonResponse({"message": f"Account deleted successfully for username: {username}"}, status=200)
                else:
                    return JsonResponse({"message": "Failed to delete account"}, status=500)
            else:
                return JsonResponse({"message": "Wrong password"}, status=401)
        else:
            return JsonResponse({"message": "Wrong username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error deleting account: {e}"}, status=500)

    
@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_collection_of_shows(request):
    body = request.data
    username = body['username']
    collection_name = body['collection_name']

    if not username or not collection_name:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Check if collection name already exists
            if any(collection['name'] == collection_name for collection in user['shows_collections_list']):
                return JsonResponse({"message": f"Collection with name '{collection_name}' already exists"}, status=409)
            # Create the new collection of shows
            new_collection = {'name': collection_name,'showsList': []}
            user['shows_collections_list'].append(new_collection)
            result = users_collection.update_one({'username': username}, {'$push': {'shows_collections_list': new_collection}})
            if result.matched_count:
                user['_id'] = str(user['_id'])
                return JsonResponse({"message": f"Collection '{collection_name}' created successfully for user: {username}", "user": user}, status=201)
            else:
                return JsonResponse({"message": "Failed to create show collection"}, status=404)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=403)
    except Exception as e:
        return JsonResponse({"message": f"Error creating collection: {e}"}, status=500)


@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def rename_collection_of_shows(request):
    body = request.data
    username = body['username']
    old_collection_name = body['old_collection_name']
    new_collection_name = body['new_collection_name']

    if not username or not old_collection_name or not new_collection_name:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Check if collection name already exists
            if any(collection['name'] == new_collection_name for collection in user['shows_collections_list']):
                return JsonResponse({"message": f"Collection with name '{new_collection_name}' already exists"}, status=409)
            # Find the collection by its old name
            collections_list = user['shows_collections_list']
            collection_found = False
            
            for collection in collections_list:
                if collection['name'] == old_collection_name:
                    collection['name'] = new_collection_name
                    collection_found = True
                    break

            if collection_found:
                # Update the user's collection in the database
                result = users_collection.update_one({'username': username},{'$set': {'shows_collections_list': collections_list}})

                if result.matched_count:
                    user['_id'] = str(user['_id'])  # Convert ObjectId to string
                    return JsonResponse({"message": f"Collection renamed successfully from '{old_collection_name}' to '{new_collection_name}'", "user": user}, status=200)
                else:
                    return JsonResponse({"message": "Failed to rename collection"}, status=500)
            else:
                return JsonResponse({"message": "Old collection name not found"}, status=404)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error renaming collection: {e}"}, status=500)

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def save_show_to_collection(request):
    body = request.data
    username = body['username']
    collection_name = body['collection_name']
    show = body['show']

    if not username or not collection_name or not show:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Find the collection by its name
            collections_list = user['shows_collections_list']
            collection_found = False
            
            for collection in collections_list:
                if collection['name'] == collection_name:
                    # Check if the show is already in the collection
                    for saved_show in collection['showsList']:  # Accessing showsList
                        if saved_show['id'] == show['id']:
                            return JsonResponse({"message": "Show already saved in this collection"}, status=400)
                    
                    # Add the show to the collection
                    collection['showsList'].append(show)
                    collection_found = True
                    break

            if collection_found:
                # Update the user's collection in the database
                result = users_collection.update_one({'username': username},{'$set': {'shows_collections_list': collections_list}})

                if result.matched_count:
                    user['_id'] = str(user['_id'])  # Convert ObjectId to string
                    get_or_create_hdbscan_clusterer(user['username'])[1] = False
                    return JsonResponse({"message": "Show saved successfully", "user": user}, status=200)
                else:
                    return JsonResponse({"message": "Failed to save show"}, status=500)
            else:
                return JsonResponse({"message": "Collection not found"}, status=404)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error saving show: {e}"}, status=500)

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def delete_shows_from_collection(request):
    body = request.data
    username = body['username']
    collection_name = body['collection_name']
    show_ids_to_delete = body['show_ids_to_delete']

    if not username or not collection_name or not show_ids_to_delete:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Find the collection by its name
            collections_list = user['shows_collections_list']
            collection_found = False

            for collection in collections_list:
                if collection['name'] == collection_name:
                    # Filter out the shows whose IDs match the list of show_ids_to_delete
                    new_shows_list = [show for show in collection['showsList'] if show['id'] not in show_ids_to_delete]

                    # If no change in showsList, return an error
                    deleted_count = len(collection['showsList']) - len(new_shows_list)
                    if deleted_count == 0:
                        return JsonResponse({"message": "No matching shows found to delete"}, status=404)

                    # Update the showsList with the filtered list
                    collection['showsList'] = new_shows_list
                    collection_found = True
                    break

            if collection_found:
                # Update the user's collection in the database
                result = users_collection.update_one({'username': username}, {'$set': {'shows_collections_list': collections_list}})

                if result.matched_count:
                    get_or_create_hdbscan_clusterer(user['username'])[1] = False
                    user['_id'] = str(user['_id'])  # Convert ObjectId to string
                    return JsonResponse({"message": f"{deleted_count} out of {len(show_ids_to_delete)} shows deleted successfully", "user": user}, status=200)

                else:
                    return JsonResponse({"message": "Failed to delete shows"}, status=500)
            else:
                return JsonResponse({"message": "Collection not found"}, status=404)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error deleting shows: {e}"}, status=500)
        
@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def delete_collections(request):
    body = request.data
    username = body['username']
    collection_names_to_delete = body['collection_names_to_delete']

    if not username or not collection_names_to_delete:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Filter out the collections whose names match the list of collection_names_to_delete
            original_collections = user['shows_collections_list']
            new_collections_list = [collection for collection in original_collections if collection['name'] not in collection_names_to_delete]

            deleted_count = len(original_collections) - len(new_collections_list)

            if deleted_count == 0:
                return JsonResponse({"message": "No matching collections found to delete"}, status=404)

            user['shows_collections_list'] = new_collections_list
            # Update the user's collections with the filtered list
            result = users_collection.update_one({'username': username}, {'$set': {'shows_collections_list': new_collections_list}})

            if result.matched_count:
                get_or_create_hdbscan_clusterer(user['username'])[1] = False
                user['_id'] = str(user['_id'])  # Convert ObjectId to string
                return JsonResponse({"message": f"{deleted_count} out of {len(collection_names_to_delete)} collections deleted successfully", "user": user}, status=200)
            else:
                return JsonResponse({"message": "Failed to delete collections"}, status=500)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error deleting collections: {e}"}, status=500)

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def post_review(request):
    body = request.data
    username = body['username']
    review = body['review']

    if not username or not review:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Add the review to the user's reviews_list
            user['reviews_list'].append(review)

            # Update the user's reviews_list in the database
            result = users_collection.update_one({'username': username}, {'$set': {'reviews_list': user['reviews_list']}})

            if result.matched_count:
                get_or_create_hdbscan_clusterer(user['username'])[1] = False
                user['_id'] = str(user['_id'])  # Convert ObjectId to string
                return JsonResponse({"message": "Review posted successfully", "user": user}, status=200)
            else:
                return JsonResponse({"message": "Failed to post review"}, status=500)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error posting review: {e}"}, status=500)

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def delete_reviews(request):
    body = request.data
    username = body['username']
    timestamps_to_delete = body['timestamps_to_delete']

    if not username or not timestamps_to_delete:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Filter out the reviews whose timestamps match the list of timestamps_to_delete
            original_reviews = user['reviews_list']
            new_reviews_list = [review for review in original_reviews if review['timestamp'] not in timestamps_to_delete]

            deleted_count = len(original_reviews) - len(new_reviews_list)

            if deleted_count == 0:
                return JsonResponse({"message": "No matching reviews found to delete"}, status=404)

            # Update the user's reviews_list with the filtered list
            user['reviews_list'] = new_reviews_list
            result = users_collection.update_one({'username': username}, {'$set':  {'reviews_list': new_reviews_list}})

            if result.matched_count:
                get_or_create_hdbscan_clusterer(user['username'])[1] = False
                user['_id'] = str(user['_id'])  # Convert ObjectId to string
                return JsonResponse({"message": f"{deleted_count} out of {len(timestamps_to_delete)} reviews deleted successfully", "user": user}, status=200)
            else:
                return JsonResponse({"message": "Failed to delete reviews"}, status=500)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error deleting reviews: {e}"}, status=500)

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def edit_review(request):
    body = request.data
    username = body['username']
    old_timestamp = body['old_timestamp']
    new_review = body['new_review']

    if not username or not old_timestamp or not new_review:
        return JsonResponse({"message": "Fields cannot be blank"}, status=400)

    try:
        user = request.user.user_data
        if user['username'] == username:
            # Find the review to edit by timestamp
            reviews_list = user['reviews_list']
            review_found = False

            for review in reviews_list:
                if review['timestamp'] == old_timestamp:
                    # Replace the old review with new_review
                    review.update(new_review)  # Update with the new review details
                    review_found = True
                    break

            if review_found:
                # Update the user's reviews_list in the database
                result = users_collection.update_one({'username': username}, {'$set':  {'reviews_list': reviews_list}})

                if result.matched_count:
                    get_or_create_hdbscan_clusterer(user['username'])[1] = False
                    user['_id'] = str(user['_id'])  # Convert ObjectId to string
                    return JsonResponse({"message": f"Review with timestamp {old_timestamp} edited successfully", "user": user}, status=200)
                else:
                    return JsonResponse({"message": "Failed to edit review"}, status=500)
            else:
                return JsonResponse({"message": "Review not found"}, status=404)
        else:
            return JsonResponse({"message": "Wrong Username"}, status=404)
    except Exception as e:
        return JsonResponse({"message": f"Error editing review: {e}"}, status=500)

@csrf_exempt
@api_view(['GET'])
@permission_classes([AllowAny])
def get_reviews_for_show(request):
    show_id = request.GET['show_id']
    if not show_id:
        return JsonResponse({"message": "Show ID cannot be blank"}, status=400)

    try:
        # Initialize an empty list to store matching reviews
        matching_reviews = []

        # Iterate over each user and their reviews
        for user in users_collection.find():
            for review in user['reviews_list']:
                # Check if the review's show ID matches the requested show ID
                if review['show']['id'] == show_id:
                    matching_reviews.append(review)

        return JsonResponse({"message": f"Reviews fetched for show ID {show_id}", "reviews": matching_reviews}, status=200)
    except Exception as e:
        return JsonResponse({"message": f"Error fetching reviews: {e}"}, status=500)

def calculate_text_vector(show):
    # Check cache for the vector using show ID
    show_id = show['id']
    if cache.get(show_id):
        return cache[show_id]  # Return cached vector

    print(show['title'] + ' ' + show['overview'])
    # Vector not in cache, need to calculate it via API request
    url = "https://openai-embedding-v3-large.p.rapidapi.com/embeddings"
    payload = {
        "input": f"{show['title']} {show['overview']}",
        "model": "text-embedding-3-large",
        "encoding_format": "float"
    }
    headers = {
        "x-rapidapi-key": settings.RAPIDAPI_KEY,  # API key from Django settings
        "x-rapidapi-host": "openai-embedding-v3-large.p.rapidapi.com",
        "Content-Type": "application/json"
    }
    
    try:
        response = requests.post(url, json=payload, headers=headers)
        response_data = response.json()
        embedding_vector = response_data.get("data", [{}])[0].get("embedding", [])
        
        if not embedding_vector:
            print("Empty embedding vector. Full response JSON:", response_data)

        # Cache the new vector and return it
        cache[show_id] = embedding_vector
        try:
            save_cache_to_file()
        except Exception as e:
            print(f"Error saving cache: {e}")
        return embedding_vector
    except Exception as e:
        print(f"Error calculating text vector: {e}")
        return None  # Return None or raise an exception if appropriate

@csrf_exempt
@api_view(['POST'])
@permission_classes([AllowAny])
def get_text_vector(request):
    body = request.data
    show = body.get('show')
    if not show:
        return JsonResponse({"message": "Show data cannot be blank"}, status=400)

    try:
        # Calculate or retrieve the text vector and store in cache
        vector = calculate_text_vector(show)
        if vector:
            return JsonResponse({"message": "Text vector calculated and cached successfully"}, status=200)
        else:
            return JsonResponse({"message": "Failed to calculate text vector"}, status=500)
    except Exception as e:
        return JsonResponse({"message": f"Error caching text vector: {e}"}, status=500)


def update_user_data_matrix(user):
    # Initialize lists for favorite shows and data matrix
    fav_shows = []
    data = []

    # Step 1: Add all shows from each collection in shows_collections_list to fav_shows
    for collection in user['shows_collections_list']:
        fav_shows.extend(collection['showsList'])

    # Step 2: Add shows with ratings >= 70 from reviews_list to fav_shows
    for review in user['reviews_list']:
        if review['rating'] >= 3.5:
            fav_shows.append(review['show'])

    # Step 3: For each show in fav_shows, retrieve its vector using calculate_text_vector
    for show in fav_shows:
        vector = calculate_text_vector(show)
        if vector:  # Only add vector if it's valid
            data.append(vector)

    # Step 4: Update user favorite_shows and data_matrix
    user['favourite_shows'] = fav_shows
    user['data_matrix'] = data  # Assign data to user's data_matrix
    # Update the user's data in MongoDB
    result = users_collection.update_one(
        {'username': user['username']},
        {
            '$set': 
            {
                'favourite_shows': user['favourite_shows'],
                'data_matrix': user['data_matrix']
            }
        }
    )
    if result.matched_count:
        return user

def fit_clustering(user):
    user = update_user_data_matrix(user)
    if user['data_matrix']:
        # Fit the HDBSCAN clusterer on the data matrix
        get_or_create_hdbscan_clusterer(user['username'])[0].fit(user['data_matrix'])
        get_or_create_hdbscan_clusterer(user['username'])[1] = True
        print(f"Cluster labels for {user['username']}", get_or_create_hdbscan_clusterer(user['username'])[0].labels_)
    return user

def get_or_create_hdbscan_clusterer(username):
    global HDBSCAN_CLUSTERER_dict
    if HDBSCAN_CLUSTERER_dict.get(username):
        return HDBSCAN_CLUSTERER_dict[username]
    # Create a new HDBSCAN object for this user with prediction enabled
    clusterer = HDBSCAN(min_cluster_size=2, prediction_data=True)
    HDBSCAN_CLUSTERER_dict[username] = [clusterer, False]
    return HDBSCAN_CLUSTERER_dict[username]

@csrf_exempt
@api_view(['POST'])
@permission_classes([IsAuthenticated])
def get_recommended_shows(request):
    body = request.data
    show_list = body.get('shows', [])
    user = request.user.user_data

    if not show_list:
        return JsonResponse({"message": "Show list cannot be blank"}, status=400)

    recommended_with_labels = []  # To store shows with their cluster labels
    try:
        for show in show_list:
            vector = calculate_text_vector(show)  # Retrieve or calculate the embedding
            if vector:
                # Predict cluster using HDBSCAN
                if not get_or_create_hdbscan_clusterer(user['username'])[1]:
                    user = fit_clustering(user)
                HDBSCAN_CLUSTERER, fitted = get_or_create_hdbscan_clusterer(user['username'])
                cluster_label = -1
                if fitted:
                    cluster_label = approximate_predict(HDBSCAN_CLUSTERER, [vector])[0][0]
                    print(f"used {user['username']}'s HDBSCAN for recommendation: {cluster_label}")
                recommended_with_labels.append((show, cluster_label)) 

        # Sort recommended shows by cluster label in descending order, outliers (-1) at the end
        recommended_with_labels.sort(key=lambda x: x[1], reverse=True)
        # Separate non-outliers and outliers from recommended_with_labels
        non_outliers = [show for show, label in recommended_with_labels if label != -1]
        outliers = [show for show, label in recommended_with_labels if label == -1]
        # Start recommended with all non-outliers
        recommended = non_outliers
        print(f"generated {len(recommended)} recommendations")
        # If less than 50, pad recommended with outliers until it reaches 50
        if len(recommended) < 50:
            recommended.extend(outliers[:50 - len(recommended)])

        user['recommended_shows'] = recommended
        # Update user's recommended_shows in the database
        result = users_collection.update_one({'username': user['username']}, {'$set': {'recommended_shows': recommended}})
        if result.matched_count:
            user['_id'] = str(user['_id'])  # Convert ObjectId to string
            return JsonResponse({"message": f"{len(recommended)} Recommendations generated successfully", "user": user}, status=200)
        else:
            return JsonResponse({"message": "Failed to update recommended shows in the database"}, status=500)
    except Exception as e:
        print(f"Error generating recommendations: {e}")
        return JsonResponse({"message": f"Error generating recommendations: {e}"}, status=500)
