# # ''''''''''''''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"
# # Uploading Media Files

# reference -> https://www.youtube.com/watch?v=I1eskLk0exg
import pyrebase
# from io import BytesIO
config = {   
    'apiKey': "AIzaSyDTxoR_8IKrGk5FrcDmy-h4IFS11D4SEWg",
    'authDomain': "meetapp-40b11.firebaseapp.com",
    'projectId': "meetapp-40b11",
    'storageBucket': "meetapp-40b11.appspot.com",
    'messagingSenderId': "382908182117",
    'appId': "1:382908182117:web:8c1142de0bfde20811208c",
    'measurementId': "G-GP8EPX0DRJ",
    'databaseURL': 'https://meetapp-40b11-default-rtdb.firebaseio.com'
}


firebase = pyrebase.initialize_app(config)
storage = firebase.storage()


def uploadFileToFireBase(file_content: bytes, file_type: str, path_on_cloud: str):
    storage.\
        child(path_on_cloud).\
        put(file_content, content_type=file_type)
    print("uploaded")


def getUrlOfFileOnCloud(path_on_cloud: str):
    file_ref = storage.child(path_on_cloud)
    url = file_ref.get_url(token=None)
    return url
    

# ''''''''''''''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"''''''''''''"
# pushing data to database
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Initialize the Firebase Admin SDK
cred = credentials.Certificate('meetapp-key.json')  # key file path
app = firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://meetapp-40b11-default-rtdb.firebaseio.com',  # Replace with your project ID
    'storageBucket': 'meetapp-40b11.appspot.com'
})



# Reference to your database
ref = db.reference('/')


def pushDataToRealtimeFBDB(data: dict):
    try:
        ref.push().set(data)
        return True
    except:
        raise Exception('Something went wrong with upserting data to ReatimeDB FireBase!!!')


def retrieve_data_by_keyword(keyword: str, key: str = "user-id", type_ret: str = "normal"): # or use 'adv'
    """
    Retrieve data from Firebase Realtime DB based on a keyword.
    key: The field (child) you want to search.
    keyword: The value of the field you are searching for.
    """
    try:
        # Query the database based on a child key and keyword
        result = ref.order_by_child(key).equal_to(keyword).get()

        # Check if data exists for the given keyword
        if result and type_ret=="normal":
            # print(f"Data found for {keyword}: {result}")
            user_medical_reports_context = list()
            for content in result:
                user_medical_reports_context.append('\n'.join(result[content]['report-content']))
            return user_medical_reports_context

        # returning cloud paths
        elif result and type_ret != "normal":
            user_medical_reports_paths = list()
            for content in result:
                user_medical_reports_paths.append('\n'.join(result[content]['report-cloud-path']))
            return user_medical_reports_paths

        else:
            return False

    except Exception as e:
        raise False


# def getUrlsOfUser(userId: str):
#     doc_paths = retrieve_data_by_keyword(userId, type_ret="adv")
#     if doc_paths is False:
#         return []
#     else:
#         full_urls = list()
#         for path in doc_paths:
#             path = path.replace('\n', '')
#             full_urls.append(
#                 {'report type': path.split('/')[1], 
#                 'url': getUrlOfFileOnCloud(path)}
#                 )
#         return full_urls


def getReportDetailsOfUser(userId: str):
    details = retrieve_data_by_keyword(userId)
    return list(set(details)) if details is not False else []

# ============

# from google.cloud import storage

# # Replace with your actual project ID and bucket name
# project_id = "birthbuddy-7d02c"
# bucket_name = "birthbuddy-7d02c.appspot.com"  # Replace with your actual bucket name

# # Create a Storage client
# storage_client = storage.Client(project=project_id)

# # Get the bucket
# bucket = storage_client.bucket(bucket_name)

# file_path_cld = "/u4aie/Blood Test Reports/bdaf45d0-80bb-47a7-a2e1-78d2fc530c44.pdf"
# # Example: Get the public URL for a file named "my_file.pdf"
# blob = bucket.blob(file_path_cld)  # Replace "my_file.pdf" with your actual file name

# # Make the file public (optional, but recommended for sharing)
# blob.make_public()

# # Get the public URL
# public_url = blob.public_url

# # Print the public URL
# print(f"Public URL: {public_url}")

if __name__ == "__main__":
    # with open('media/reports/blood_test.pdf', 'rb') as jammer:
    #     uploadFileToFireBase(jammer.read(), 'application/pdf','random.pdf')
    # pushDataToRealtimeFBDB({"HELLO": "HI"})
    
    # sample "Jasmine52341%2FBlood%20Test%20Reports%2F0acfcff3-bb27-4dbd-a156-b62b2bb789ce.pdf?alt=media&token=b3517f4d-0e3f-4d00-8fda-05825d45ac57"
    # print(*retrieve_data_by_keyword('Sam1023'), sep="\n\n\n")
    # list_of_urls = list()
    # for path in 
    # print(getUrlsOfUser('KatrinaBn1423')[0].replace('\n', ''))

    # try calling urls
    # print(getUrlsOfUser('KatrinaBn1423e'))

    print(pushDataToRealtimeFBDB({"OM": "PUSHING :)"}))
    ...


# # putting from local to cloud
# path_on_cloud = "images/foo.jpg"
# path_on_local = "media/images/test-image-1.jpg"

'''
with open(path_on_local, 'rb') as jammer:
        storage.child(path_on_cloud).put(jammer.read(), content_type='image/jpeg')
'''