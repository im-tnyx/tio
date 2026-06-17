import os
from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel
from dotenv import load_dotenv

# Import services
from services.edamam_service import EdamamService
from services.fatsecret_service import FatSecretService

# Load environment variables from monorepo root (.env)
dotenv_path = os.path.join(os.path.dirname(__file__), "../../.env")
if os.path.exists(dotenv_path):
    load_dotenv(dotenv_path=dotenv_path)
else:
    load_dotenv() # Fallback to current folder

app = FastAPI(title="TIO AI & Computation Service", version="1.0.0")

# Instantiate services
edamam_client = EdamamService()
fatsecret_client = FatSecretService()

class ParseRequest(BaseModel):
    text: str

@app.get("/")
def read_root():
    return {"message": "Welcome to TIO AI & Computation Service"}

@app.get("/health")
def health_check():
    # Basic check to see if credentials are loaded
    credentials_ok = bool(
        os.getenv("EDAMAM_APP_ID") and 
        os.getenv("EDAMAM_APP_KEY") and
        os.getenv("FATSECRET_CLIENT_ID") and
        os.getenv("FATSECRET_CLIENT_SECRET")
    )
    return {
        "status": "healthy",
        "credentials_loaded": credentials_ok
    }

@app.post("/api/nutrition/parse")
async def parse_nutrition(payload: ParseRequest):
    if not payload.text.strip():
        raise HTTPException(status_code=400, detail="Text query cannot be empty")
    
    try:
        result = await edamam_client.parse_food_text(payload.text)
        return result
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Failed to parse with Edamam: {str(e)}")

@app.get("/api/nutrition/search")
async def search_food(query: str = Query(..., description="Food name to search for")):
    if not query.strip():
        raise HTTPException(status_code=400, detail="Search query cannot be empty")
        
    try:
        result = await fatsecret_client.search_food(query)
        return result
    except ValueError as e:
        raise HTTPException(status_code=500, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=502, detail=f"Failed to search with FatSecret: {str(e)}")

