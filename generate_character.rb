require_relative 'creatures/character'
require_relative 'items/items'
require_relative 'skills/skills'
require_relative 'skills/magic'

FileUtils.mkpath( 'data/characters' )

c = Character.new
c.print

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

def_modes = { dodge: Skills, shield: Items } # TODO : parry is hard because it need to work with all weapons
puts 'Select def mode'.blue
input = hash_choice( def_modes )
mode = def_modes[ input ].get( input )

weapons = { sword: Items, bow: Items, magic_missile: Skills }
puts 'Select current weapon'.blue
input = hash_choice( weapons )
weapon = weapons[ input ].get( input )

begin
  puts 'Enter starting position (1-5)'.blue
  input = gets.chomp.to_i

  if input < 1 || input > 5
    puts 'bad range'
    bad_range = true
  end
end while bad_range

c.set_fighting_spec( mode, weapon, input )

File.open( "data/characters/#{c.name}.cha", 'w' ) do |f|
  f.puts( Marshal.dump( c ) )
end