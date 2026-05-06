from core.group import Group
from entities.character import Character, CHARACTER_CLASSES


class Party(Group):
    _member_class = Character

    def _initialize_members(self) -> None:
        for char_class in CHARACTER_CLASSES:
            member = Character(None, char_class, self.competences_file)
            self.members[member.combatant_id] = member
