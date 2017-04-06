require_relative 'creatures/character'
require_relative 'items/items'
require_relative 'skills/skills'
require_relative 'skills/magic'

c = Character.new

c.print

def_modes = { dodge: Skills, shield: Items }
# { name: :parry, _class: Skills }, TODO : parry is hard because it need to work with all weapons
begin
  puts "Enter def mode : #{def_modes.keys.inspect}"
  input = gets.chomp.to_sym

  unless def_modes[ input ]
    puts "mode #{input.inspect} does not exist"
  else
    mode = def_modes[ input ].get( input )
  end
end until mode

weapons = { sword: Items, bow: Items, magic_missile: Skills }
begin
  puts "Enter current weapon : #{weapons.keys.inspect}"
  input = gets.chomp.to_sym

  unless weapons[ input ]
    puts 'weapon does not exist'
  else
    weapon = weapons[ input ].get( input )
  end
end until weapon

begin
  puts 'Enter starting position (1-5)'
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