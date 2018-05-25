class RunParams < OpenStruct
  def beginning
    return if start_date.blank? || start_time.blank?
    Time.zone.parse(start_time, Time.zone.parse(start_date))
  end

  def model_attrs
    {
      place: place,
      beginning: beginning,
      start_date: start_date,
      start_time: start_time,
      tempo: tempo,
      distance: distance,
      competition_id: competition_id
    }
  end
end
