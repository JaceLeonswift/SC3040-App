from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from django.conf import settings

# Replace with your MongoDB connection string
uri = settings.MONGODB_CONNECTION_STRING

# Create a new client and connect to the server using ServerApi
client = MongoClient(uri, server_api=ServerApi('1'))

# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)

# Access the database and collection
db = client['SC3040']
users_collection = db['User_Information']


