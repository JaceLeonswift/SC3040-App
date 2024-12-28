from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.exceptions import AuthenticationFailed
from .db import users_collection 
from bson import ObjectId

class CustomJWTAuthentication(JWTAuthentication):
    def get_user(self, validated_token):
        try:
            # Extract the custom user_id from the validated token
            user_id = validated_token.get('user_id')
            if not user_id:
                raise AuthenticationFailed('Token contained no recognizable user identification')

            # Convert user_id to ObjectId for MongoDB lookup
            user_id = ObjectId(user_id)
            # Fetch the user from MongoDB using the ObjectId
            user = users_collection.find_one({'_id': user_id})
            if user is None:
                raise AuthenticationFailed('User not found')

            # Returning the user as a dictionary, making sure to convert _id to string
            user['_id'] = str(user['_id'])
            return CustomUser(user)
        except Exception as e:
            raise AuthenticationFailed(f'Invalid token or user lookup failed: {e}')
        
class CustomUser:
    def __init__(self, user):
        self.user_data = user
        self.is_authenticated = True

    def __str__(self):
        return self.user_data
