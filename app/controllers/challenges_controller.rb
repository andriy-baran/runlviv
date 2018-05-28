class ChallengesController < ApplicationController
  def index
    @challenges =
      Challenge
        .joins(:competitions)
        .where('competitions.start <= ?', Time.zone.now)
        .where('competitions.finish > ?', Time.zone.now)
        .uniq
  end
end
