require_relative 'lib/stats/model_compare'

mc = ModelCompare.new

[ :regular, :advantage, :disadvantage ].each do |roll_type|
  puts "roll type = #{roll_type}"
  puts

  [ true, false ].each do |strict_superiority|
    mc.compute_results( roll_type, strict_superiority, 1.upto(20) )
  end

  mc.results_to_yaml 'results'

  mc.charts_data_to_yaml
end
