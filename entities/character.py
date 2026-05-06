import random
from typing import Any, Dict, Optional

from core.combatant import Combatant

CHARACTER_CLASSES: Dict[str, Any] = {
    "warrior": {"competences": ["weapon:melee:short_sword", "equipment:defense:hand_shield_small"]},
    "thief":   {"competences": ["weapon:ranged:short_bow"]},
    "wizard":  {"competences": ["magic:arcane:magic_missile", "magic:arcane:magic_shield"]},
}

_FIRST_NAMES = [
    "Aldric", "Brynn", "Cedric", "Darian", "Elara", "Finn", "Gwendolyn", "Harald",
    "Isolde", "Jareth", "Kael", "Lyanna", "Marius", "Nyx", "Orin", "Percival",
    "Rowena", "Soren", "Thalia", "Ulric", "Varian", "Wren", "Xander", "Ysolde", "Zephyr",
]
_LAST_NAMES = [
    "Blackwood", "Ironforge", "Stormwind", "Ravencrest", "Thornheart", "Silverbrook",
    "Darkwater", "Goldleaf", "Ashwood", "Stonebear", "Flameheart", "Frostborn",
    "Shadowbane", "Brightblade", "Moonwhisper", "Oakenshield", "Swiftarrow", "Steelheart",
]


class Character(Combatant):
    @classmethod
    def _get_types(cls) -> Dict[str, Any]:
        return CHARACTER_CLASSES

    def _default_name(self) -> str:
        return f"{random.choice(_FIRST_NAMES)} {random.choice(_LAST_NAMES)}"
