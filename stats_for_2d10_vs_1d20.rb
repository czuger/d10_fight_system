require_relative 'lib/stats/model_compare'

[ true, false ].each do |advantage|
  puts "Advantage = #{advantage}"
  puts
  [ 9.step(11,1), 5.step(15,5) ].each do |enumerator|
    mc = ModelCompare.new( advantage )
    mc.compute_results( enumerator )
    mc.print_results
    puts
  end
end
