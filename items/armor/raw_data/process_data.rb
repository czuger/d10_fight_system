require 'pp'
require 'yaml'

armors = {}
titles = {}

File.open('armors_protection.txt','r') do |file|
  file.readlines.each_with_index do |line, index|
    line = line.chomp.split( "\t" )
    if index == 0
      line.shift
      line.each_with_index do |title, index|
        titles[index] = title.downcase.gsub(' ','_').to_sym
      end
    else
      damage_source = line.shift.downcase.gsub(' ','_').to_sym
      armors[damage_source] = {}
      line.each_with_index do |protection, index|
        armors[damage_source][titles[index]] = -protection.to_i
      end
    end
  end
end

File.open('../armors_protections.yaml','w') do |f|
  f.write(armors.to_yaml)
end

armors = {}

File.open('armors_localisation_protection.txt','r') do |file|
  file.readlines.each_with_index do |line, index|
    line = line.chomp.split( "\t" )
    if index == 0
      next
    else
      prot_localisation = line.shift.downcase.gsub(' ','_').to_sym
      armors[prot_localisation] = []
      line.each_with_index do |protection, index|
        armors[prot_localisation] << titles[index] if protection == 'X'
      end
    end
  end
end

File.open('../armors_localisation_protection.yaml','w') do |f|
  f.write(armors.to_yaml)
end