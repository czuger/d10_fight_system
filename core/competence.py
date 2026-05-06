import json
from pathlib import Path
from typing import Any, Dict, Optional

from core import DEFAULT_COMPETENCES_FILE


class Competence:
    """A single competence loaded from the competences registry.

    Args:
        competence_name: Namespaced key e.g. "weapon:melee:short_sword"
        competences_file: Path to the JSON registry (defaults to data/competences.json)
    """

    def __init__(self, competence_name: str, competences_file: str = DEFAULT_COMPETENCES_FILE):
        self.name = competence_name
        self._load(competences_file)

    def _load(self, competences_file: str) -> None:
        with open(competences_file, "r") as f:
            all_competences = json.load(f)
        if self.name not in all_competences:
            raise ValueError(f"Competence '{self.name}' not found in {competences_file}")
        data = all_competences[self.name]
        self.learning_difficulty: int = data["learning_difficulty"]
        self.current_bonus: int = data["current_bonus"]
        self.result: Dict[str, Dict[str, Any]] = data["result"]

    def get_result(self, result_type: str) -> Optional[Dict[str, Any]]:
        return self.result.get(result_type)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "learning_difficulty": self.learning_difficulty,
            "current_bonus": self.current_bonus,
            "result": self.result,
        }

    def __repr__(self) -> str:
        return f"Competence(name='{self.name}', difficulty={self.learning_difficulty}, bonus={self.current_bonus})"
