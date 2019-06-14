require 'yaml'
require_relative '../lib/stats/html_updater'

include HtmlUpdater

def stat_cell( data, target, dice, status, index )
  "<td class='%s text-center'>%s</td>" % [ "target_#{target}_#{index % 2}", ((data[target][dice][status]*100/data[target][dice][:sum]).round(0).to_s.gsub( '.', ',' ) + ' &#37;') ]
end

def dice_number_to_text( number )
  return 'd20' if number == 20
  '2d10'
end

data = YAML.load_file( 'data/regular.yaml' )
keys = data.keys.sort

upper_header = keys.map{ |k| "<th class='text-center target_#{k}_0' colspan=2>#{k}</th>" }.insert( 0, "<th rowspan=2 ></th>" ).join( '' )
lower_header = keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| "<th class='text-center target_#{k}_1'>#{dice_number_to_text(sk)}</th>" } }.flatten.join( '' )
header = "<tr>#{upper_header}</tr><tr>#{lower_header}</tr>"

body = ''
[:critical_failure, :failure, :success, :critical_success].each_with_index do |status, index|
  body_line = "<td>#{status.capitalize.to_s.gsub( '_', ' ' )}</td>" + keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| stat_cell( data, k, sk, status, index ) } }.flatten.join( '' )
  body += "<tr>#{body_line}</tr>"
end

table = "<table class='table table-striped'><thead>#{header}</thead><tbody>#{body}</tbody></table>\n"

add_lines_after 'website/fr/index.html', '<!--TABLE_1-->', table