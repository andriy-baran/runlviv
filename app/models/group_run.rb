class GroupRun < ApplicationRecord
  has_many :runs
  has_many :users, through: :runs

  validates :place, :beginning, :start_date, :start_time, presence: true

  attr_accessor :start_date, :start_time

  after_initialize :set_time_and_date

  def users_names
    runs.map{ |run| run.user.name }.join(', ')
  end

  private

  def set_time_and_date
    return unless beginning
    self.start_date = beginning.to_date.to_s
    self.start_time = beginning.strftime('%H:%M')
  end
end
