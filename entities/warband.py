from core.group import Group
from entities.monster import Monster, MONSTER_TYPES


class Warband(Group):
    _member_class = Monster

    def _initialize_members(self) -> None:
        for monster_type in MONSTER_TYPES:
            member = Monster(None, monster_type, self.competences_file)
            self.members[member.combatant_id] = member
