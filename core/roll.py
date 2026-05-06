import random
from dataclasses import dataclass
from typing import List


@dataclass
class RollResult:
    """Result of a 2d10 competence roll.

    Attributes:
        success: True if total >= 10
        critical: True if both dice show the same value
        dice_outcome: The two individual die values
        total: 2d10 + bonus - difficulty
    """
    success: bool
    critical: bool
    dice_outcome: List[int]
    total: int


def roll_competence(difficulty: int = 0, bonus: int = 0) -> RollResult:
    die1 = random.randint(1, 10)
    die2 = random.randint(1, 10)
    total = die1 + die2 + bonus - difficulty
    return RollResult(
        success=total >= 10,
        critical=die1 == die2,
        dice_outcome=[die1, die2],
        total=total,
    )
