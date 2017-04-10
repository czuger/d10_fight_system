require_relative '../../creatures/character'
require_relative '../../skills/magic'
require_relative '../../skills/creature_skill'
require_relative '../../items/creature_item'

def hash_choice( hash )
  keys = hash.keys

  puts 'Enter choice'

  begin

    bad_input = false

    keys.each_with_index do |key, i|
      puts "#{i} -> #{key}"
    end

    input = gets.chomp
    choose_number = input.to_i

    if choose_number < 0 || choose_number >= keys.size
      puts "Bad input : #{input.inspect}"
      bad_input = true
    end

    # p bad_input
  end while bad_input

  keys[ choose_number ]
end

def create_action_link( link_mode, creature )

  if link_mode.kind_of?( Skill )
    result = CreatureSkill.find_or_create_by!( creature: creature, skill: link_mode )
  else
    skill = CreatureSkill.find_or_create_by!( creature: creature, skill: link_mode.skill )
    result = CreatureItem.find_or_create_by!( creature: creature, item: link_mode, creature_skill: skill ) do |item|
      item.hp = link_mode.hp
    end
  end
  result
end

def set_data( creature )
  def_modes = {dodge: Skill, shield: Item } # TODO : parry is hard because it need to work with all weapons
  puts 'Select def mode'.blue

  input = hash_choice( def_modes )

  def_mode = def_modes[ input ].find_by( name: input )
  creature.def_mode = create_action_link( def_mode, creature )

  weapons = { sword: Item, bow: Item, magic_missile: Skill }
  puts 'Select current weapon'.blue
  input = hash_choice( weapons )

  weapon = weapons[ input ].find_by( name: input )
  creature.current_weapon = create_action_link( weapon, creature )

  begin
    puts 'Enter starting position (1-5)'.blue
    input = gets.chomp.to_i

    if input < 1 || input > 5
      puts 'bad range'
      bad_range = true
    else
      creature.default_position = creature.current_position = input
    end
  end while bad_range

  creature.save!
end