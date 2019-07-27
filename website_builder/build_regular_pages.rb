require 'yaml'
require 'i18n'
require 'fileutils'
require 'json'

require_relative '../lib/stats/html_updater'

include HtmlUpdater

def stat_cell( data, target, dice, status, row_oddity, keys_index )
  # p "dice = #{dice}, target = #{target}"
  # p data[target][dice]

  # p keys_index

  result = data[target][dice][status]
  result ||= 0

  "<td class='%s text-center'>%s</td>" % [ "target_#{keys_index}_#{row_oddity % 2}", ((result*100/data[target][dice][:sum]).round(0).to_s.gsub( '.', ',' ) + ' &#37;') ]
end

def dice_number_to_text( number )
  return 'd20' if number == 20
  '2d10'
end

def build_table( data, keys, table_anchor, locale )
  upper_header = keys.each_with_index.map{ |k, i| "<th class='text-center target_#{i}_0' colspan=2>#{k}</th>" }.insert( 0, "<th rowspan=2 ></th>" ).join( '' )
  lower_header = keys.each_with_index.map{ |k, i| data[k].keys.sort.reverse.map{ |sk| "<th class='text-center target_#{i}_1'>#{dice_number_to_text(sk)}</th>" } }.flatten.join( '' )
  header = "<tr>#{upper_header}</tr><tr>#{lower_header}</tr>"

  body_data = {}
  body = ''
  [ :critical_success, :success, :failure, :critical_failure ].each_with_index do |status, index|
    body_line = "<td>#{I18n.t('results.'+status.to_s)}</td>" + keys.each_with_index.map{ |k, keys_index| data[k].keys.sort.reverse.map{ |sk| stat_cell( data, k, sk, status, index, keys_index ) } }.flatten.join( '' )

    body += "<tr>#{body_line}</tr>"
  end

  table = "<table class='table table-striped'><thead>#{header}</thead><tbody>#{body}</tbody></table>\n"

  # add_lines_after "website/#{locale}/index.html", "<!--#{table_anchor}-->", table

  File.open( 'website_builder/table.html', 'w' ) do |f|
    f.puts table
  end

  File.open( 'middleman/data/table.yaml', 'w' ) do |f|
    f.puts data.to_yaml
  end
end

def fill_text( locale )
  I18n.backend.send(:translations)[:fr][:texts].keys.each do |t|
    add_lines_after "website/#{locale}/index.html", "<!--#{t.upcase}-->", I18n.t("texts.#{t}")
  end
end

def add_json_data( data, locale )
  d20_data = data.map{ |target, s_data_1| [ target, s_data_1[20][:success] * 100 / s_data_1[20][:sum] ] }.sort.map{ |e| e.last }
  d20_critical = data.map{ |target, s_data_1| [ target, s_data_1[20][:critical_success] * 100 / s_data_1[20][:sum] ] }.sort.map{ |e| e.last }

  _2d20_data = data.map{ |target, s_data_1| [ target, s_data_1[10][:success] * 100 / s_data_1[10][:sum] ] }.sort.map{ |e| e.last }
  _2d20_critical = data.map{ |target, s_data_1| [ target, s_data_1[10][:critical_success] * 100 / s_data_1[10][:sum] ] }.sort.map{ |e| e.last }

  json_data = { 'd20' => d20_data, 'd20_critical' => d20_critical, 'd10' => _2d20_data, 'd10_critical' => _2d20_critical }

  # add_lines_after "website/#{locale}/index.html", "<!--JSON_CHARTS_DATA-->", "<input id='json_data' type='hidden' value='#{json_data.to_json}'>"

  File.open( 'middleman/data/charts.yml', 'w' ) do |f|
    f.puts json_data.to_yaml
  end
end

def add_json_charts_translations locale
  # add_lines_after "website/#{locale}/index.html", "<!--JSON_CHART_TRANSLATIONS-->", "<input id='2d10_data' type='hidden' value='#{_2d20_data.to_json}'>"
end

I18n.load_path = Dir['config/*.yml']
I18n.backend.load_translations
I18n.available_locales = [:fr, :en]

`ruby stats_for_2d10_vs_1d20.rb`

I18n.available_locales.each do |locale|
  I18n.locale = locale

  data = YAML.load_file( 'data/regular.yaml' )

  FileUtils.copy( 'website_builder/index_template.html', "website/#{locale}/index.html" )
  # fill_text locale
  # build_table data, [ 4, 6, 8, 10, 12, 14, 16 ], 'TABLE1', locale
  # build_table data, [ 7, 8, 9, 10, 11, 12, 13 ], 'TABLE2', locale
  # build_table data, [ 14, 15, 16, 17, 18, 19, 20 ], 'TABLE3', locale

  add_json_data data, locale

  # add_json_charts_translations locale
end