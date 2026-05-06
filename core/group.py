import json
from abc import ABC, abstractmethod
from pathlib import Path
from typing import Dict, List, Optional, Type

from core import DEFAULT_COMPETENCES_FILE
from core.combatant import Combatant


class Group(ABC):
    """Abstract base for a named collection of Combatants.

    Subclasses must define:
      - _member_class: the Combatant subclass this group contains
      - _initialize_members(): populate self.members with default members
    """

    _member_class: Type[Combatant]

    def __init__(self, group_id: str, competences_file: str = DEFAULT_COMPETENCES_FILE):
        self.group_id = group_id
        self.members: Dict[str, Combatant] = {}
        self.competences_file = competences_file
        self._initialize_members()

    @abstractmethod
    def _initialize_members(self) -> None: ...

    def add_member(self, member: Combatant) -> None:
        self.members[member.combatant_id] = member

    def get_member(self, member_id: str) -> Optional[Combatant]:
        return self.members.get(member_id)

    def get_all_members(self) -> List[Combatant]:
        return list(self.members.values())

    def save_to_json(self, path: str) -> None:
        doc = {
            "group_id": self.group_id,
            "members": {mid: m.to_dict() for mid, m in self.members.items()},
        }
        Path(path).write_text(json.dumps(doc, indent=2))

    def load_from_json(self, path: str) -> None:
        doc = json.loads(Path(path).read_text())
        self.group_id = doc["group_id"]
        self.members = {}
        for member_id, member_data in doc["members"].items():
            member = self._member_class._from_dict(member_data, self.competences_file)
            self.members[member_id] = member

    def __repr__(self) -> str:
        return f"{self.__class__.__name__}(id='{self.group_id}', members={len(self.members)})"
