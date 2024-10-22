from fastapi import APIRouter, Depends, status, HTTPException, Body, File, UploadFile

from firebase_helper import uploadFileToFireBase, pushDataToRealtimeFBDB

from pinecone_helper import upsertDataChooseNameSpace

from wrapper import typeDocInputNOutputFormat, model

from fastapi import FastAPI, File, UploadFile, Form

from .models import UserData

router = APIRouter(
    prefix="/user-storage",
    tags=['User-Analysis and Storage']
)


@router.get('/test')
def testApp():
    return {"Works": "Like a Charm!"}


@router.post("/create-profile")
async def create_profile(
    name: str,
    age: int,
    gender: str,
    partner_preferences: str,
    bio: str,
    cuisine_preferences: str,
    user_dp: UploadFile = File(...)
):

    # uploading File to FireStore
    file_content = await user_dp.read()
    file_type = user_dp.content_type
    _, file_extension = user_dp.filename.split('.')

    cloud_path = F"{name}.{file_extension}"

    uploadFileToFireBase(file_content, file_type, cloud_path)
    
    # Upserting Data to The Vector Store.
    upsertDataChooseNameSpace(0, bio, name, gender) # bio
    upsertDataChooseNameSpace(1, partner_preferences, name, gender) # partner-preference
    upsertDataChooseNameSpace(2, cuisine_preferences, name, gender) # cusine-preference

    return {"Upsertion": "Successful :))"}



# @router.post("/recommend-location-spot")
# async def create_profile(
#     name: str,
#     age: int,
#     gender: str,
#     partner_preferences: str,
#     bio: str,
#     cuisine_preferences: str,
#     user_dp: UploadFile = File(...)
# ):

#     # uploading File to FireStore
#     file_content = await user_dp.read()
#     file_type = user_dp.content_type
#     _, file_extension = user_dp.filename.split('.')

#     cloud_path = F"{name}.{file_extension}"

#     uploadFileToFireBase(file_content, file_type, cloud_path)
    
#     # Upserting Data to The Vector Store.
#     upsertDataChooseNameSpace(0, bio, name, gender) # bio
#     upsertDataChooseNameSpace(1, partner_preferences, name, gender) # partner-preference
#     upsertDataChooseNameSpace(2, cuisine_preferences, name, gender) # cusine-preference

#     return {"Upsertion": "Successful :))"}
