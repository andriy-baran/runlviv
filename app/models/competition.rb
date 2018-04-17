class Competition < ApplicationRecord
  belongs_to :challenge

  def full_title
    "#{challenge.title} - #{title}"
  end
end
