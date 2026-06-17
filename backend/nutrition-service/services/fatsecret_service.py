import os
import time
import logging
import httpx
from typing import Dict, Any, Optional

logger = logging.getLogger(__name__)

class FatSecretService:
  def __init__(self):
    self.client_id = os.getenv("FATSECRET_CLIENT_ID")
    self.client_secret = os.getenv("FATSECRET_CLIENT_SECRET")
    
    self.token_url = "https://oauth.fatsecret.com/connect/token"
    self.api_url = "https://platform.fatsecret.com/rest/server.api"
    
    self._cached_token: Optional[str] = None
    self._token_expiry: float = 0.0

  async def _get_access_token(self) -> str:
    # Return cached token if valid
    if self._cached_token and time.time() < self._token_expiry:
      return self._cached_token

    if not self.client_id or not self.client_secret:
      logger.error("FatSecret credentials not configured in environment")
      raise ValueError("FatSecret API credentials are not set")

    # Request new token using client_credentials grant
    async with httpx.AsyncClient() as client:
      try:
        response = await client.post(
          self.token_url,
          auth=(self.client_id, self.client_secret),
          data={"grant_type": "client_credentials", "scope": "basic"},
          timeout=10.0
        )
        response.raise_for_status()
        data = response.json()
        
        self._cached_token = data["access_token"]
        # Expire 30 seconds early for safety margin
        self._token_expiry = time.time() + float(data.get("expires_in", 3600)) - 30.0
        return self._cached_token
      except Exception as e:
        logger.error(f"FatSecret OAuth token exchange failed: {str(e)}")
        raise RuntimeError(f"FatSecret Authentication error: {str(e)}")

  async def search_food(self, query: str) -> Dict[str, Any]:
    token = await self._get_access_token()

    params = {
      "method": "foods.search",
      "search_expression": query,
      "format": "json"
    }
    
    headers = {
      "Authorization": f"Bearer {token}"
    }

    async with httpx.AsyncClient() as client:
      try:
        response = await client.get(self.api_url, params=params, headers=headers, timeout=10.0)
        response.raise_for_status()
        data = response.json()
        
        return self._normalize_search_response(data)
      except httpx.HTTPStatusError as e:
        logger.error(f"FatSecret API returned error code {e.response.status_code}: {e.response.text}")
        raise RuntimeError(f"FatSecret API search failed: {e.response.text}")
      except Exception as e:
        logger.error(f"FatSecret API request error: {str(e)}")
        raise RuntimeError(f"FatSecret API query failed: {str(e)}")

  def _normalize_search_response(self, data: Dict[str, Any]) -> Dict[str, Any]:
    # Extract foods from response structure
    foods_wrapper = data.get("foods", {})
    food_list = foods_wrapper.get("food", [])
    
    # Handle single item returned as a dict instead of a list
    if isinstance(food_list, dict):
      food_list = [food_list]
      
    normalized_foods = []
    
    for food in food_list:
      desc = food.get("food_description", "")
      macros = self._parse_description_macros(desc)
      
      normalized_foods.append({
        "food_id": food.get("food_id"),
        "food_name": food.get("food_name"),
        "food_type": food.get("food_type"),
        "food_url": food.get("food_url"),
        "description": desc,
        "calories": macros.get("calories", 0.0),
        "protein_g": macros.get("protein", 0.0),
        "carbs_g": macros.get("carbs", 0.0),
        "fat_g": macros.get("fat", 0.0)
      })

    return {
      "success": True,
      "query": foods_wrapper.get("max_results") or "",
      "foods": normalized_foods
    }

  def _parse_description_macros(self, desc: str) -> Dict[str, float]:
    # Parsing description like: "Per 100g - Calories: 52kcal | Fat: 0.17g | Carbs: 13.81g | Protein: 0.26g"
    result = {"calories": 0.0, "fat": 0.0, "carbs": 0.0, "protein": 0.0}
    if not desc:
      return result
      
    try:
      # Split by | character
      parts = desc.split("|")
      for part in parts:
        part = part.lower().strip()
        if "calories:" in part:
          val_str = part.replace("calories:", "").replace("kcal", "").strip()
          result["calories"] = float(val_str)
        elif "fat:" in part:
          val_str = part.replace("fat:", "").replace("g", "").strip()
          result["fat"] = float(val_str)
        elif "carbs:" in part:
          val_str = part.replace("carbs:", "").replace("g", "").strip()
          result["carbs"] = float(val_str)
        elif "protein:" in part:
          val_str = part.replace("protein:", "").replace("g", "").strip()
          result["protein"] = float(val_str)
    except Exception as e:
      logger.warning(f"Failed to parse macros from FatSecret description '{desc}': {str(e)}")
      
    return result
