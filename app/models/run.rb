class Run < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  validates :place, :beginning, :start_date, :start_time, presence: true

  attr_accessor :start_date, :start_time
end
