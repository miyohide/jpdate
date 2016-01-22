require "date"

class Jpdate
  MEIJI  = 1867
  TAISHO = 1911
  SHOWA  = 1925
  HEISEI = 1988

  NAME_TYPE_ERROR_STRING = "Name should be String."
  NAME_VALUE_ERROR_STRING = "Name should be 'M', 'T', 'S' or 'H'."
  YEAR_TYPE_ERROR_STRING = "Year should be Integer."
  YEAR_VALUE_ERROR_STRING = "Year should be greater than or equal to 1."
  MONTH_TYPE_ERROR_STRING = "Month should be Integer."
  MONTH_VALUE_ERROR_STRING = "Month should be greater than or equal to 1. And less than or equal to 12."
  DAY_TYPE_ERROR_STRING = "Day should be Integer."
  DAY_VALUE_ERROR_STRING = "Day should be greater than or equal to 1. And less than or equal to 31."

  # Constructor
  # @param [String] name Japanese era name. "M", "T", "S" or "H"
  # @param [Integer] year Japanese era year >= 1
  # @param [Integer] month month. 1 <= month <= 12.
  # @param [Integer] day day. 1 <= day <= 31.
  # @raise [ArgumentError] if name, year, month or day is not valid.
  # @return [Jpdate] Jpdate object.
  def initialize(name, year, month, day)
    @name  = name
    @year  = year
    @month = month
    @day   = day

    validate!
  end

  private

  def validate!
    validate_name!
    validate_year!
    validate_month!
    validate_day!
  end

  def validate_name!
    raise ArgumentError, NAME_TYPE_ERROR_STRING unless @name.is_a?(String)
    raise ArgumentError,
      NAME_VALUE_ERROR_STRING if @name.scan(/\A[MTSH]\Z/).empty?
  end

  def validate_year!
    raise ArgumentError, YEAR_TYPE_ERROR_STRING unless @year.is_a?(Integer)
    raise ArgumentError, YEAR_VALUE_ERROR_STRING if @year < 1
  end

  def validate_month!
    raise ArgumentError, MONTH_TYPE_ERROR_STRING unless @month.is_a?(Integer)
    raise ArgumentError, MONTH_VALUE_ERROR_STRING if @month < 1 || @month > 12
  end

  def validate_day!
    raise ArgumentError, DAY_TYPE_ERROR_STRING unless @day.is_a?(Integer)
    raise ArgumentError, DAY_VALUE_ERROR_STRING if @day < 1 || @day > 31
  end
end
