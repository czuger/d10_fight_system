# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Python rewrite (branch `python_version`) of a D10 tabletop RPG fight system, previously implemented in Ruby. The system handles competence-based combat rolls, character creation, party management, and encounters between parties and warbands.

## Setup

```bash
# Run a full encounter demo (no dependencies required)
python encounter.py
```

## Project structure

```
core/           Base mechanics and abstract classes
  roll.py         roll_competence() → RollResult (2d10 + bonus - difficulty)
  competence.py   Competence: loads one entry from the JSON registry
  combatant.py    Combatant (ABC): base for Character and Monster
  group.py        Group (ABC): base for Party and Warband

entities/       Concrete domain objects
  character.py    Character(Combatant): warrior / thief / wizard
  monster.py      Monster(Combatant): orc / goblin / skeleton
  party.py        Party(Group): one of each character class
  warband.py      Warband(Group): one of each monster type

data/
  competences.json  Single source of truth for all competence definitions

encounter.py    Encounter: round-based fight between a Party and a Warband
```

## Architecture

**Core mechanic (`core/roll.py`):** Roll 2d10 + bonus - difficulty. Success if total >= 10. Critical if both dice show the same value (doubles).

**Competence system (`core/competence.py` + `data/competences.json`):** Competences are namespaced with colons: `category:subcategory:name` (e.g., `weapon:melee:short_sword`, `magic:arcane:magic_missile`). Each competence defines four outcomes: `success`, `failure`, `critical_success`, `critical_failure`. Result types are: `damage` (with a dice roll expression), `none`, `attack_block`, `self_hurt`, `equipment_damage`.

**Combatant ABC (`core/combatant.py`):** Holds `combatant_id`, `name`, `combatant_type`, `competences`. Subclasses implement `_get_types()` (returns the type registry dict) and `_default_name()`. All serialization (`to_dict`, `_from_dict`, `save_to_json`, `load_from_json`) lives here.

**Group ABC (`core/group.py`):** Holds `group_id`, `members`. Subclasses set `_member_class` and implement `_initialize_members()`. All serialization lives here.

**Character / Monster (`entities/`):** Each is ~10 lines — just the type registry and a default name strategy. `CHARACTER_CLASSES` and `MONSTER_TYPES` dicts are the only entity-specific data.

**Encounter (`encounter.py`):** Pairs living combatants randomly each round (shorter side cycles). Both sides roll simultaneously; `attack_block` results negate incoming `damage`. Tracks HP externally via a `{combatant_id: int}` dict.

## Data

`data/competences.json` is the single source of truth for all competence definitions. Add new competences there before referencing them in `CHARACTER_CLASSES`, `MONSTER_TYPES`, or character/monster code.
