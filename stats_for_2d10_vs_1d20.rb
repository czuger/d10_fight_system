require_relative 'lib/stats/model_compare'

[ :regular, :advantage, :disadvantage ].each do |roll_type|
  puts "roll type = #{roll_type}"
  puts
  [ 8.step(12,2), 6.step(14,4), 4.step(16,6) ].each do |enumerator|
    mc = ModelCompare.new( roll_type )
    mc.compute_results( enumerator )
    # mc.print_results

    mc.results_to_html

    puts
    puts
  end
end
