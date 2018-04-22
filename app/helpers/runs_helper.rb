module RunsHelper
  def tempo_options
    [I18n.t('domain.runs.tempo.low'),
    I18n.t('domain.runs.tempo.medium'),
    I18n.t('domain.runs.tempo.hight')]
  end

  def strava_activity_path(id)
    "https://www.strava.com/activities/#{id}"
  end
end
