from fastapi import FastAPI

# routers
from upload_user_details import register_user
from recommend_locations import recommend_locations
# from report_analysis_and_storage import report_analysis
# from exercise_recommendation import exercise_recommendation

app = FastAPI(
    title="MeetApp",
)

# including routers
app.include_router(register_user.router)
app.include_router(recommend_locations.router)

# app.include_router(report_analysis.router)
# app.include_router(exercise_recommendation.router)
# app.include_router(user.router)