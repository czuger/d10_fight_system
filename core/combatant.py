import json
import random
import uuid
from abc import ABC, abstractmethod
from pathlib import Path
from typing import Any, Dict, Optional

from core import DEFAULT_COMPETENCES_FILE
from core.competence import Competence


class Combatant(ABC):
    """Abstract base for any entity that participates in combat.

    Subclasses must define:
      - _get_types(): classmethod returning {type_name: {"competences": [...]}, ...}
      - _default_name(): returns a name string when none is provided
    """

    @classmethod
    @abstractmethod
    def _get_types(cls) -> Dict[str, Any]: ...

    @abstractmethod
    def _default_name(self) -> str: ...

    def __init__(
        self,
        name: Optional[str],
        combatant_type: Optional[str],
        competences_file: str = DEFAULT_COMPETENCES_FILE,
    ):
        self.competences_file = competences_file
        types = self._get_types()

        if combatant_type is None:
            combatant_type = random.choice(list(types.keys()))
        if combatant_type not in types:
            raise ValueError(f"Unknown type '{combatant_type}' for {self.__class__.__name__}")

        self.combatant_id = str(uuid.uuid4())
        self.combatant_type = combatant_type
        self.name = name if name is not None else self._default_name()
        self.competences: Dict[str, Competence] = {}
        self._initialize_competences()

    def _initialize_competences(self) -> None:
        for comp_name in self._get_types()[self.combatant_type]["competences"]:
            self.competences[comp_name] = Competence(comp_name, self.competences_file)

    def add_competence(self, name: str) -> None:
        if name not in self.competences:
            self.competences[name] = Competence(name, self.competences_file)

    def get_competence(self, name: str) -> Optional[Competence]:
        return self.competences.get(name)

    def to_dict(self) -> Dict[str, Any]:
        return {
            "combatant_id": self.combatant_id,
            "name": self.name,
            "combatant_type": self.combatant_type,
            "competences": {n: c.to_dict() for n, c in self.competences.items()},
        }

    @classmethod
    def _from_dict(cls, data: Dict[str, Any], competences_file: str = DEFAULT_COMPETENCES_FILE) -> "Combatant":
        instance = cls.__new__(cls)
        instance.competences_file = competences_file
        instance._load_dict(data)
        return instance

    def _load_dict(self, doc: Dict[str, Any]) -> None:
        self.combatant_id = doc["combatant_id"]
        self.name = doc["name"]
        self.combatant_type = doc["combatant_type"]
        self.competences = {}
        for comp_name, comp_data in doc["competences"].items():
            comp = Competence(comp_name, self.competences_file)
            comp.learning_difficulty = comp_data["learning_difficulty"]
            comp.current_bonus = comp_data["current_bonus"]
            comp.result = comp_data["result"]
            self.competences[comp_name] = comp

    def save_to_json(self, path: str) -> None:
        Path(path).write_text(json.dumps(self.to_dict(), indent=2))

    def load_from_json(self, path: str) -> None:
        self._load_dict(json.loads(Path(path).read_text()))

    def __repr__(self) -> str:
        return (
            f"{self.__class__.__name__}(id='{self.combatant_id[:8]}...', "
            f"name='{self.name}', type='{self.combatant_type}', "
            f"competences={len(self.competences)})"
        )
