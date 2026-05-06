import random
import re
from typing import Any, Dict, List, Optional

from core.combatant import Combatant
from core.roll import roll_competence
from entities.party import Party
from entities.warband import Warband


def _roll_dice(expr: str) -> int:
    m = re.match(r"(\d+)d(\d+)", expr)
    if not m:
        return 0
    count, sides = int(m.group(1)), int(m.group(2))
    return sum(random.randint(1, sides) for _ in range(count))


class Encounter:
    """A fight between a Party and a Warband.

    Args:
        party: The party of adventurers
        warband: The opposing warband of monsters
        hp_per_combatant: Starting HP for every combatant
    """

    def __init__(self, party: Party, warband: Warband, hp_per_combatant: int = 10):
        self.party = party
        self.warband = warband
        self.hp_per_combatant = hp_per_combatant
        self.round_number = 0
        self.hp: Dict[str, int] = {
            m.combatant_id: hp_per_combatant
            for m in party.get_all_members() + warband.get_all_members()
        }

    def _living(self, group) -> List[Combatant]:
        return [m for m in group.get_all_members() if self.hp[m.combatant_id] > 0]

    def _roll_action(self, combatant: Combatant) -> Dict[str, Any]:
        comp_name = random.choice(list(combatant.competences.keys()))
        comp = combatant.competences[comp_name]
        roll = roll_competence(difficulty=comp.learning_difficulty, bonus=comp.current_bonus)

        if roll.critical and roll.success:
            result_key = "critical_success"
        elif roll.critical:
            result_key = "critical_failure"
        elif roll.success:
            result_key = "success"
        else:
            result_key = "failure"

        result = comp.get_result(result_key)
        return {
            "comp_name": comp_name,
            "result_key": result_key,
            "result_type": result["type"],
            "roll_expr": result.get("roll"),
        }

    def _apply_action(
        self, action: Dict, actor: Combatant, target: Combatant, blocked: bool, logs: List[str]
    ) -> None:
        result_type = action["result_type"]

        if result_type == "damage":
            if blocked:
                logs.append(f"    {actor.name}'s attack is blocked by {target.name}!")
            else:
                dmg = _roll_dice(action["roll_expr"])
                self.hp[target.combatant_id] = max(0, self.hp[target.combatant_id] - dmg)
                logs.append(
                    f"    {actor.name} deals {dmg} damage to {target.name}"
                    f" (HP: {self.hp[target.combatant_id]}/{self.hp_per_combatant})"
                )
        elif result_type == "self_hurt":
            dmg = _roll_dice(action["roll_expr"])
            self.hp[actor.combatant_id] = max(0, self.hp[actor.combatant_id] - dmg)
            logs.append(
                f"    {actor.name} hurts themselves for {dmg}"
                f" (HP: {self.hp[actor.combatant_id]}/{self.hp_per_combatant})"
            )
        elif result_type == "attack_block":
            logs.append(f"    {actor.name} braces for a block")
        elif result_type == "equipment_damage":
            logs.append(f"    {actor.name}'s equipment takes damage")
        else:
            logs.append(f"    {actor.name}: no effect")

    def run_round(self) -> List[str]:
        """Run one round of combat and return log lines."""
        self.round_number += 1
        logs = [f"\n--- Round {self.round_number} ---"]

        living_party = self._living(self.party)
        living_monsters = self._living(self.warband)

        if not living_party or not living_monsters:
            return logs

        random.shuffle(living_party)
        random.shuffle(living_monsters)

        # Shorter side cycles to face multiple opponents
        for i in range(max(len(living_party), len(living_monsters))):
            char = living_party[i % len(living_party)]
            monster = living_monsters[i % len(living_monsters)]

            if self.hp[char.combatant_id] <= 0 or self.hp[monster.combatant_id] <= 0:
                continue

            char_action = self._roll_action(char)
            monster_action = self._roll_action(monster)

            logs.append(
                f"  {char.name} [{char_action['comp_name']}]"
                f" vs {monster.name} [{monster_action['comp_name']}]"
            )
            logs.append(
                f"    {char.name}: {char_action['result_key']}"
                f"  |  {monster.name}: {monster_action['result_key']}"
            )

            self._apply_action(
                char_action, actor=char, target=monster,
                blocked=monster_action["result_type"] == "attack_block" and char_action["result_type"] == "damage",
                logs=logs,
            )
            self._apply_action(
                monster_action, actor=monster, target=char,
                blocked=char_action["result_type"] == "attack_block" and monster_action["result_type"] == "damage",
                logs=logs,
            )

        for c in living_party:
            if self.hp[c.combatant_id] <= 0:
                logs.append(f"  *** {c.name} has fallen! ***")
        for m in living_monsters:
            if self.hp[m.combatant_id] <= 0:
                logs.append(f"  *** {m.name} has been slain! ***")

        return logs

    def is_over(self) -> bool:
        return not self._living(self.party) or not self._living(self.warband)

    def winner(self) -> Optional[str]:
        lp = bool(self._living(self.party))
        lm = bool(self._living(self.warband))
        if lp and not lm:
            return "party"
        if lm and not lp:
            return "warband"
        if not lp and not lm:
            return "draw"
        return None

    def run(self, max_rounds: int = 100) -> str:
        """Run the full encounter. Returns 'party', 'warband', 'draw', or 'timeout'."""
        print("=== Encounter begins! ===")
        print(f"Party:   {[m.name for m in self._living(self.party)]}")
        print(f"Warband: {[f'{m.name} ({m.combatant_type})' for m in self._living(self.warband)]}")

        while not self.is_over() and self.round_number < max_rounds:
            for line in self.run_round():
                print(line)

        result = self.winner() or "timeout"
        print(f"\n=== Encounter over after {self.round_number} round(s) ===")
        if result == "party":
            print("Victory! The party triumphs!")
        elif result == "warband":
            print("Defeat! The warband prevails!")
        elif result == "draw":
            print("Both sides have fallen — a pyrrhic battle!")
        else:
            print(f"Stalemate after {max_rounds} rounds.")
        return result


def main() -> None:
    party = Party("adventurers_001")
    warband = Warband("warband_001")
    Encounter(party, warband, hp_per_combatant=10).run()


if __name__ == "__main__":
    main()
