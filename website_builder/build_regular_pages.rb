require 'yaml'
require_relative '../lib/stats/html_updater'

include HtmlUpdater

def stat_cell( data, target, dice, status )
  "<td class='%s'>%s</td>" % [ "target_#{target}", ((data[target][dice][status]*100/data[target][dice][:sum]).round(2).to_s.gsub( '.', ',' ) + ' &#37;') ]
end

data = YAML.load_file( 'data/regular.yaml' )
keys = data.keys.sort

upper_header = keys.map{ |k| "<th colspan=2>#{k}</th>" }.insert( 0, '<th></th>' ).join( '' )
lower_header = keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| "<th>#{sk}</th>" } }.flatten.insert( 0, '<th></th>' ).join( '' )
header = "<tr>#{upper_header}</tr><tr>#{lower_header}</tr>"

body = ''
[:critical_failure, :failure, :success, :critical_success].each do |status|
  body_line = "<td>#{status.capitalize.to_s.gsub( '_', ' ' )}</td>" + keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| stat_cell( data, k, sk, status ) } }.flatten.join( '' )
  body += "<tr>#{body_line}</tr>"
end

table = "<table class=\"table\"><thead>#{header}</thead><tbody>#{body}</tbody></table>\n"

add_lines_after 'website/fr/index.html', '<!--TABLE_1-->', table