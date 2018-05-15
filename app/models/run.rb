class Run < ApplicationRecord
  belongs_to :user
  belongs_to :group_run
  belongs_to :competition
  has_many :strava_imports

  validates :place, :beginning, :start_date, :start_time, presence: true

  attr_accessor :start_date, :start_time

  after_initialize :set_time_and_date

  private

  def set_time_and_date
    return unless beginning
    self.start_date = beginning.to_date.to_s
    self.start_time = beginning.strftime('%H:%M')
  end
end
