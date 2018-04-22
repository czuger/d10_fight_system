require 'active_record'

class Team < ActiveRecord::Base

 has_many :characters, class_name: 'Character'

end