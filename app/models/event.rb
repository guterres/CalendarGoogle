class Event
  include ActiveModel::Model

  attr_accessor :title, :date_start, :time_start, :date_end, :time_end, :location, :description

  validates_presence_of :title, :date_start, :time_start, :date_end, :time_end, :location, :description

  validate :validate_date_start
  validate :validate_time_start
  validate :validate_date_end
  validate :validate_time_end

  private

  def validate_date_start
    errors.add(:date_start, 'must be a valid date') if (DateTime.parse(date_start) rescue ArgumentError) == ArgumentError
  end

  def validate_time_start
    errors.add(:time_start, 'must be a valid time') if (DateTime.parse(time_start) rescue ArgumentError) == ArgumentError
  end

  def validate_date_end
    errors.add(:date_end, 'must be a valid date') if (DateTime.parse(date_end) rescue ArgumentError) == ArgumentError
  end

  def validate_time_end
    errors.add(:time_end, 'must be a valid time') if (DateTime.parse(time_end) rescue ArgumentError) == ArgumentError
  end

end
