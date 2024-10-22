from pydantic import BaseModel

# Create a Pydantic model for non-file data if you want to use JSON
class UserData(BaseModel):
    name: str
    age: int
    gender: str
    partner_preferences: str
    bio: str
    cuisine_preferences: str