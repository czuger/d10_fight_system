require 'yaml'
require 'i18n'
require 'fileutils'

require_relative '../lib/stats/html_updater'

include HtmlUpdater

def stat_cell( data, target, dice, status, index )
  "<td class='%s text-center'>%s</td>" % [ "target_#{target}_#{index % 2}", ((data[target][dice][status]*100/data[target][dice][:sum]).round(0).to_s.gsub( '.', ',' ) + ' &#37;') ]
end

def dice_number_to_text( number )
  return 'd20' if number == 20
  '2d10'
end

def build_table( locale )
  data = YAML.load_file( 'data/regular.yaml' )
  keys = data.keys.sort

  upper_header = keys.map{ |k| "<th class='text-center target_#{k}_0' colspan=2>#{k}</th>" }.insert( 0, "<th rowspan=2 ></th>" ).join( '' )
  lower_header = keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| "<th class='text-center target_#{k}_1'>#{dice_number_to_text(sk)}</th>" } }.flatten.join( '' )
  header = "<tr>#{upper_header}</tr><tr>#{lower_header}</tr>"

  body = ''
  [ :critical_success, :success, :failure, :critical_failure ].each_with_index do |status, index|
    body_line = "<td>#{I18n.t('results.'+status.to_s)}</td>" + keys.map{ |k| data[k].keys.sort.reverse.map{ |sk| stat_cell( data, k, sk, status, index ) } }.flatten.join( '' )
    body += "<tr>#{body_line}</tr>"
  end

  table = "<table class='table table-striped'><thead>#{header}</thead><tbody>#{body}</tbody></table>\n"

  add_lines_after "website/#{locale}/index.html", '<!--TABLE1-->', table
end

def fill_text( locale )
  %w( header1 intro1 intro2 ).each do |t|
    add_lines_after "website/#{locale}/index.html", "<!--#{t.upcase}-->", I18n.t("texts.#{t}")
  end
end

I18n.load_path = Dir['config/*.yml']
I18n.backend.load_translations
I18n.available_locales = [:fr, :en]

I18n.available_locales.each do |locale|
  I18n.locale = locale

  FileUtils.copy( 'website_builder/index_template.html', "website/#{locale}/index.html" )
  fill_text locale
  build_table locale
end