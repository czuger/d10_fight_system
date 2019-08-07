require 'hazard'
require 'pp'
require 'yaml'

require_relative '../core/check2d10'
require_relative '../core/check_d20'

require_relative 'html_updater'

class ModelCompare

  DIFFICULTY_TEXT= { 4 => :easy, 6 => :easy, 8 => :easy, 10 => :medium, 12 => :hard, 14 => :hard, 16 => :hard }

  include HtmlUpdater

  def initialize
    @results= {}
  end

  def compute_results( roll_type, strict_superiority, steps_enumerator )
    steps_enumerator.each do |target|
      permutations_d20.each do |roll|
        check_d20(roll_type, strict_superiority, target,  roll)
      end

      permutations_d10.each do |roll|
        check_2d10(roll_type, strict_superiority, target,  roll)
      end
    end
  end

  def print_results
    keys = @results.keys.sort
    puts "\t" + keys.map{ |k| k[4..-1] }.join( "\t" )

    [:critical_failure, :failure, :success, :critical_success].each do |status|
      puts "#{status.capitalize.to_s.gsub( '_', ' ' )}\t" + keys.map{ |k| (@results[k][status]/@results[k][:sum]).round(5).to_s.gsub( '.', ',' ) }.join( "\t" )
    end
  end

  def results_to_html
    pp @results
    keys = @results.keys.sort

    header = keys.map{ |k| "<th>#{k[4..-1]}</th>" }.insert( 0, '<th></th>' ).join( '' )
    header = "<tr>#{header}</tr>"

    body = ''
    [:critical_failure, :failure, :success, :critical_success].each do |status|
      body_line = "<td>#{status.capitalize.to_s.gsub( '_', ' ' )}</td>" + keys.map{ |k| "<td class='%s'>%s</td>" % [ key_to_class(k), ((@results[k][status]*100/@results[k][:sum]).round(2).to_s.gsub( '.', ',' ) + ' &#37;') ] }.join( '' )
      body += "<tr>#{body_line}</tr>"
    end

    table = "<table class=\"table\">#{header}#{body}</table>\n"

    add_lines_after 'website/fr/index.html', '<!--TABLE_1-->', table
  end

  def results_to_yaml( filename )
    # current_data = YAML.load_file( "data/#{filename}.yaml" )

    # p @results[8][10]

    File.open( "data/#{filename}.yaml", 'w' ) do |f|
      f.write @results.to_yaml
    end
  end
  
  private

  def key_to_class(key)
    match = key.match( /\d+ Target  ?(\d+), \d?d(\d+)/ )

    difficulty = match[1]
    dice = match[2]

    '%s_%s' % [ DIFFICULTY_TEXT[difficulty.to_i], dice]
  end

  def permutations_d20
    if @roll_type != :regular
      1.upto(20).to_a.repeated_permutation(2)
    else
      1.upto(20).to_a.repeated_permutation(1)
    end
  end

  def permutations_d10
    if @roll_type != :regular
      1.upto(10).to_a.repeated_permutation(3)
    else
      1.upto(10).to_a.repeated_permutation(2)
    end
  end

  def increase_hashes_value(roll_type, strict_superiority, target, dice, result)

    strict_superiority = strict_superiority ? 'strict_superiority' : 'superior_or_equal'
    @results[roll_type] ||= {}
    @results[roll_type][strict_superiority] ||= {}
    @results[roll_type][strict_superiority][target] ||= {}

    tmp_results = { :critical_failure => 0.0, :sum => 0.0, :failure => 0.0, :success => 0.0, :critical_success => 0.0 }

    # p "result = '#{result.status.inspect}'"
    # tmp_results[result.status] += 1.0

    tmp_results[:success] += 1.0 if result.status == :critical_success
    tmp_results[:failure] += 1.0 if result.status == :critical_failure

    tmp_results[:sum] += 1.0

    @results[roll_type][strict_superiority][target][dice] = tmp_results
  end

  def check_2d10(roll_type, strict_superiority, target,  roll)
    result = Check2d10.new.roll( roll_type: roll_type, strict_superiority: strict_superiority, target: target, rolls: roll )
    increase_hashes_value roll_type, strict_superiority, target, 10, result
  end

  def check_d20(roll_type, strict_superiority, target,  roll)
    result = CheckD20.new.roll( roll_type: roll_type, strict_superiority: strict_superiority, target: target, rolls: roll )
    increase_hashes_value roll_type, strict_superiority, target, 20, result
  end
  
  # def target_key(target, dice)
  #   dice_name = (dice==10) ? '2d10' : 'd20'
  #   '%2d%2d Target %2d, %s' % [ target, dice, target, dice_name ]
  # end
  
end