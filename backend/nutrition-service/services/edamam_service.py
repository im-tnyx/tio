import os
import logging
import httpx
from typing import Dict, Any, Optional

logger = logging.getLogger(__name__)

class EdamamService:
  def __init__(self):
    self.app_id = os.getenv("EDAMAM_APP_ID")
    self.app_key = os.getenv("EDAMAM_APP_KEY")
    self.base_url = "https://api.edamam.com/api/food-database/v2/parser"

  async def parse_food_text(self, text: str) -> Dict[str, Any]:
    if not self.app_id or not self.app_key:
      logger.error("Edamam credentials not configured in environment")
      raise ValueError("Edamam API credentials are not set")

    params = {
      "ingr": text,
      "app_id": self.app_id,
      "app_key": self.app_key
    }

    async with httpx.AsyncClient() as client:
      try:
        response = await client.get(self.base_url, params=params, timeout=10.0)
        response.raise_for_status()
        data = response.json()
        
        return self._normalize_parser_response(data)
      except httpx.HTTPStatusError as e:
        logger.error(f"Edamam API returned error code {e.response.status_code}: {e.response.text}")
        raise RuntimeError(f"Edamam API failed: {e.response.text}")
      except Exception as e:
        logger.error(f"Failed to query Edamam API: {str(e)}")
        raise RuntimeError(f"Edamam API request error: {str(e)}")

  def _normalize_parser_response(self, data: Dict[str, Any]) -> Dict[str, Any]:
    # Extract parsed foods and their nutrients
    parsed_items = data.get("parsed", [])
    hints = data.get("hints", [])
    
    # We prioritize the "parsed" list. If empty, fallback to the first "hint"
    food_data = None
    quantity = 1.0
    measure = "serving"
    
    if parsed_items:
      first_item = parsed_items[0]
      food_data = first_item.get("food", {})
      quantity = first_item.get("quantity", 1.0)
      measure = first_item.get("measure", {}).get("label", "serving")
    elif hints:
      food_data = hints[0].get("food", {})

    if not food_data:
      return {
        "success": False,
        "message": f"Could not parse nutrition for input: {data.get('text', '')}",
        "raw_text": data.get("text", ""),
        "items": []
      }

    nutrients = food_data.get("nutrients", {})
    
    # Edamam nutrient keys:
    # ENERC_KCAL: Calories (kcal)
    # PROCNT: Protein (g)
    # FAT: Fat (g)
    # CHOCDF: Carbs (g)
    # FIBTG: Fiber (g)
    
    normalized_data = {
      "success": True,
      "food_label": food_data.get("label", "Unknown Food"),
      "category": food_data.get("category", "Generic"),
      "quantity": quantity,
      "measure": measure,
      "calories": nutrients.get("ENERC_KCAL", 0.0),
      "protein_g": nutrients.get("PROCNT", 0.0),
      "carbs_g": nutrients.get("CHOCDF", 0.0),
      "fat_g": nutrients.get("FAT", 0.0),
      "fiber_g": nutrients.get("FIBTG", 0.0)
    }

    return normalized_data
