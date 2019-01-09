require_relative 'lib/stats/model_compare'

[ true, false ].each do |advantage|
  puts "Advantage = #{advantage}"
  puts
  [ 8.step(12,2), 6.step(14,4), 4.step(16,6) ].each do |enumerator|
    mc = ModelCompare.new( advantage )
    mc.compute_results( enumerator )
    mc.print_results
    puts
    puts
  end
end
