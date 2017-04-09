require_relative '../interface/characters/set_data'

FileUtils.mkpath( '../data/characters' )

c = Character.new

if File.exist?( "../data/characters/#{c.name}.cha" )
  puts 'Character already exist.'
  exit
end

c.print
c = set_data( c )

if c
  File.open( "../data/characters/#{c.name}.cha", 'w' ) do |f|
    f.puts( Marshal.dump( c ) )
  end
end
