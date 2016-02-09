require_relative "jpdate"

module AD2Jpdate
  # 明治は1868年からだが、1873年までは日本は天保暦であったため、とりあえず未対応
  MEIJI_ERA  = 18730101..19120730
  TAISHO_ERA = 19120730..19261225
  SHOWA_ERA  = 19261225..19890107
  HEISEI_ERA = 19890108

  RANGE_ERROR_MSG_STRING = "date is >= #{MEIJI_ERA.min}"

  JP_ERA = {
    meiji:  { en: "M", ja: "明治", year: Jpdate::MEIJI  },
    taisho: { en: "T", ja: "大正", year: Jpdate::TAISHO },
    showa:  { en: "S", ja: "昭和", year: Jpdate::SHOWA  },
    heisei: { en: "H", ja: "平成", year: Jpdate::HEISEI }
  }

  JP_ERAS = Struct.new(:meiji, :taisho, :showa, :heisei)

  # return to Japanese date
  # @param [String] format format string. Time#strftime format string +
  #                 %o : Short Japanese era name.("M","T","S" or "H")
  #                 %O : Japanese era name.("明治", "大正", "昭和" or "平成")
  #                 %J : Jananese era year.
  # @return [String] formated Japanese date.
  def to_jp(format = "%o%J.%m.%d")
    strfera(format)
  end

  private

  def strfera(format)
    date = self.strftime("%Y%m%d").to_i
    raise RangeError, RANGE_ERROR_MSG_STRING if date < MEIJI_ERA.min

    jpdate = JP_ERAS.new
    jpdate.meiji  = convert_stdformat(convert_eraformat(format, :meiji)) if MEIJI_ERA.include?(date)
    jpdate.taisho = convert_stdformat(convert_eraformat(format, :taisho)) if TAISHO_ERA.include?(date)
    jpdate.showa  = convert_stdformat(convert_eraformat(format, :showa)) if SHOWA_ERA.include?(date)
    jpdate.heisei = convert_stdformat(convert_eraformat(format, :heisei)) if date >= HEISEI_ERA
    jpdate
  end

  def convert_eraformat(format, era_name)
    era = JP_ERA[era_name]
    jpdate = format.gsub(/%o/, era[:en])
    jpdate.gsub!(/%O/, era[:ja])
    jpdate.gsub!(/%J/, sprintf("%02d", year - era[:year]))
    jpdate
  end

  def convert_stdformat(format)
    self.strftime(format)
  end
end

class Time
  include AD2Jpdate
end

class Date
  include AD2Jpdate
end
