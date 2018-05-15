class Competition < ApplicationRecord
  belongs_to :challenge
  has_many :runs
  has_many :users, through: :runs

  def user_result(user_id)
    total =
      runs
        .joins(:strava_imports)
        .where(user_id: user_id)
        .pluck('strava_imports.distance')
        .map(&:to_f)
        .sum

  end

  def user_progress(user_id)
    total = user_result(user_id)
    ((total / 5000) * 100).to_i
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
    return 'Не Розпрочатий' if not_started?
  end
end
