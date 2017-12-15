class Run < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'

  attr_reader :start_date, :start_time
end
