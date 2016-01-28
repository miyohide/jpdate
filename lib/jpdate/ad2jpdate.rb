require_relative "jpdate"

module AD2Jpdate
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

  def to_jadate(format = "%o%J.%m.%d")
    jpdate = strfera(format)
    jpdate.map! do |fmt|
      self.strftime(fmt)
    end
  end

  def strfera(format)
    date = self.strftime("%Y%m%d").to_i
    raise RangeError, RANGE_ERROR_MSG_STRING if date < MEIJI_ERA.min

    jpdate = []
    jpdate << convert(format, :meiji) if MEIJI_ERA.include?(date)
    jpdate << convert(format, :taisho) if TAISHO_ERA.include?(date)
    jpdate << convert(format, :showa) if SHOWA_ERA.include?(date)
    jpdate << convert(format, :heisei) if date >= HEISEI_ERA
    jpdate
  end

  def convert(format, era_name)
    era = JP_ERA[era_name]
    jpdate = format.gsub(/%o/, era[:en])
    jpdate.gsub!(/%O/, era[:ja])
    jpdate.gsub!(/%J/, sprintf("%02d", year - era[:year]))
    jpdate
  end
end

class Time
  include AD2Jpdate
end