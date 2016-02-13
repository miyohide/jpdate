require "spec_helper"

describe "Time#to_jp" do
  context "should raise RangeError when" do
    it "1872/12/31" do
      expect { Time.mktime(1872, 12, 31).to_jp }
        .to raise_error(RangeError, AD2Jpdate::RANGE_ERROR_MSG_STRING)
    end
  end

  describe "return current Japanese era date" do
    context "Meiji era start" do
      subject { Time.mktime(1873, 1, 1).to_jp }
      it { expect(subject.meiji).to eql("M06.01.01")}
      it { expect(subject.taisho).to be_nil }
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Meiji era start + 1" do
      subject { Time.mktime(1873, 1, 2).to_jp }
      it { expect(subject.meiji).to eql("M06.01.02")}
      it { expect(subject.taisho).to be_nil }
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Meiji era last - 2" do
      subject { Time.mktime(1912, 7, 28).to_jp }
      it { expect(subject.meiji).to eql("M45.07.28")}
      it { expect(subject.taisho).to be_nil }
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Meiji era last - 1" do
      subject { Time.mktime(1912, 7, 29).to_jp }
      it { expect(subject.meiji).to eql("M45.07.29")}
      it { expect(subject.taisho).to be_nil }
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Meiji era last and Taisho era start" do
      subject { Time.mktime(1912, 7, 30).to_jp }
      it { expect(subject.meiji).to eql("M45.07.30")}
      it { expect(subject.taisho).to eql("T01.07.30")}
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Taisho era start + 1" do
      subject { Time.mktime(1912, 7, 31).to_jp }
      it { expect(subject.meiji).to eql("M45.07.31") }
      it { expect(subject.taisho).to eql("T01.07.31") }
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Taisho era start + 2" do
      subject { Time.mktime(1912, 8, 1).to_jp }
      it { expect(subject.meiji).to eql("M45.08.01") }
      it { expect(subject.taisho).to eql("T01.08.01")}
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Taisho era last - 2" do
      subject { Time.mktime(1926, 12, 23).to_jp }
      it { expect(subject.meiji).to eql("M59.12.23") }
      it { expect(subject.taisho).to eql("T15.12.23")}
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Taisho era last - 1" do
      subject { Time.mktime(1926, 12, 24).to_jp }
      it { expect(subject.meiji).to eql("M59.12.24") }
      it { expect(subject.taisho).to eql("T15.12.24")}
      it { expect(subject.showa).to be_nil }
      it { expect(subject.heisei).to be_nil }
    end

    context "Taisho era last and Syowa era start" do
      subject { Time.mktime(1926, 12, 25).to_jp }
      it { expect(subject.meiji).to eql("M59.12.25") }
      it { expect(subject.taisho).to eql("T15.12.25")}
      it { expect(subject.showa).to eql("S01.12.25")}
      it { expect(subject.heisei).to be_nil }
    end

    context "Syowa era start + 1" do
      subject { Time.mktime(1926, 12, 26).to_jp }
      it { expect(subject.meiji).to eql("M59.12.26") }
      it { expect(subject.taisho).to eql("T15.12.26") }
      it { expect(subject.showa).to eql("S01.12.26")}
      it { expect(subject.heisei).to be_nil }
    end

    context "Syowa era start + 2" do
      subject { Time.mktime(1926, 12, 27).to_jp }
      it { expect(subject.meiji).to eql("M59.12.27") }
      it { expect(subject.taisho).to eql("T15.12.27") }
      it { expect(subject.showa).to eql("S01.12.27")}
      it { expect(subject.heisei).to be_nil }
    end

    context "Syowa era last - 1" do
      subject { Time.mktime(1989, 1, 6).to_jp }
      it { expect(subject.meiji).to eql("M122.01.06") }
      it { expect(subject.taisho).to eql("T78.01.06") }
      it { expect(subject.showa).to eql("S64.01.06")}
      it { expect(subject.heisei).to be_nil }
    end

    context "Syowa era last" do
      subject { Time.mktime(1989, 1, 7).to_jp }
      it { expect(subject.meiji).to eql("M122.01.07") }
      it { expect(subject.taisho).to eql("T78.01.07") }
      it { expect(subject.showa).to eql("S64.01.07")}
      it { expect(subject.heisei).to be_nil }
    end

    context "Heisei era start" do
      subject { Time.mktime(1989, 1, 8).to_jp }
      it { expect(subject.meiji).to eql("M122.01.08") }
      it { expect(subject.taisho).to eql("T78.01.08") }
      it { expect(subject.showa).to eql("S64.01.08") }
      it { expect(subject.heisei).to eql("H01.01.08")}
    end

    context "Heisei era start + 1" do
      subject { Time.mktime(1989, 1, 9).to_jp }
      it { expect(subject.meiji).to eql("M122.01.09") }
      it { expect(subject.taisho).to eql("T78.01.09") }
      it { expect(subject.showa).to eql("S64.01.09") }
      it { expect(subject.heisei).to eql("H01.01.09")}
    end
  end

  describe "format type field" do
    context "type field is %O" do
      subject { Time.mktime(1989, 1, 9).to_jp("%O%J年%m月%d日").heisei }
      it { is_expected.to eql("平成01年01月09日")}
    end
  end
end

describe "Date#to_jp" do
  context "Meiji" do
    subject { Date.new(1873, 1, 1).to_jp.meiji }
    it { is_expected.to eql("M06.01.01") }
  end

  context "Taisho" do
    subject { Date.new(1912, 7, 30).to_jp }
    it { expect(subject.meiji).to eql("M45.07.30") }
    it { expect(subject.taisho).to eql("T01.07.30") }
  end

  context "SHOWA" do
    subject { Date.new(1926, 12, 26).to_jp.showa }
    it { is_expected.to eql("S01.12.26") }
  end

  context "Heisei" do
    subject { Date.new(1989, 1, 9).to_jp.heisei }
    it { is_expected.to eql("H01.01.09") }
  end
end
