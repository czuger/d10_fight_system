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

def set_data( c )
  def_modes = {dodge: Skill, shield: Item } # TODO : parry is hard because it need to work with all weapons
  puts 'Select def mode'.blue

  # input = hash_choice( def_modes )
  input = :shield

  def_mode = def_modes[ input ].find_by( name: input )
  p def_modes[ input ]
  p def_mode

  # weapons = { sword: Item, bow: Item, magic_missile: Skill }
  # puts 'Select current weapon'.blue
  # input = hash_choice( weapons )
  # weapon = weapons[ input ].get( input )
  #
  # begin
  #   puts 'Enter starting position (1-5)'.blue
  #   input = gets.chomp.to_i
  #
  #   if input < 1 || input > 5
  #     puts 'bad range'
  #     bad_range = true
  #   end
  # end while bad_range

  if def_mode.kind_of?( Skill )
    def_mode_link = CreatureSkill.find_or_create_by!( creature: c, skill: def_mode )
  else
    skill = CreatureSkill.find_or_create_by!( creature: c, skill: def_mode.skill )
    def_mode_link = CreatureItem.find_or_create_by!( creature: c, item: def_mode, creature_skill: skill ) do |item|
      item.hp = def_mode.hp
    end
  end

  c.def_mode = def_mode_link
end