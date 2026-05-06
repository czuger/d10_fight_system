from typing import Any, Dict

from core.combatant import Combatant

MONSTER_TYPES: Dict[str, Any] = {
    "orc":      {"competences": ["weapon:melee:axe"]},
    "goblin":   {"competences": ["weapon:melee:short_sword"]},
    "skeleton": {"competences": ["weapon:melee:short_sword"]},
}


class Monster(Combatant):
    @classmethod
    def _get_types(cls) -> Dict[str, Any]:
        return MONSTER_TYPES

    def _default_name(self) -> str:
        return self.combatant_type.capitalize()
