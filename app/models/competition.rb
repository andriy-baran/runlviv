class Competition < ApplicationRecord
  belongs_to :challenge
  has_many :runs
  has_many :users, through: :runs
  has_many :strava_imports, through: :runs

  store_accessor :rules, :min_distance

  def user_result(user_id)
    runs
      .joins(:strava_imports)
      .where(user_id: user_id)
      .pluck('strava_imports.distance')
      .map(&:to_f)
      .sum
  end

  def user_progress(user_id = nil, result: nil)
    total = result || user_result(user_id)
    ((total / min_distance.to_f) * 100).to_i
  end

  def full_title
    "#{challenge.title} - #{title}"
  end

  def actual?
    (start..finish).cover? Date.today
  end

  def not_started?
    start > Date.today
  end

  def finished?
    finish < Date.today
  end

  def status
    return 'Завершений' if finished?
    return 'Поточний' if actual?
    return 'Не Розпочатий' if not_started?
  end
end
