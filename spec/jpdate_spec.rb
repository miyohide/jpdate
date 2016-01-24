require 'spec_helper'

describe Jpdate do
  it 'has a version number' do
    expect(Jpdate::VERSION).not_to be nil
  end

  describe "argument validation" do
    context "should raise ArgumentError when" do
      it "name is not String" do
        expect{ Jpdate.new(0, 1, 1, 1) }.
          to raise_error(ArgumentError, Jpdate::NAME_TYPE_ERROR_STRING)
      end

      it "name is not 'M', 'T', 'S', or 'H'" do
        expect{ Jpdate.new("G", 1, 1, 1) }.
          to raise_error(ArgumentError, Jpdate::NAME_VALUE_ERROR_STRING)
      end

      it "name is 'M'" do
        expect( Jpdate.new("M", 1, 1, 1) ).
          to be_an_instance_of(Jpdate)
      end

      it "year is not Integer" do
        expect{ Jpdate.new("M", "1", 1, 1) }.
          to raise_error(ArgumentError, Jpdate::YEAR_TYPE_ERROR_STRING)
      end

      it "year is less than 1" do
        expect{ Jpdate.new("M", 0, 1, 1) }.
          to raise_error(ArgumentError, Jpdate::YEAR_VALUE_ERROR_STRING)
      end

      it "year is more than or equal to 1" do
        expect(Jpdate.new("M", 1, 1, 1)).to be_an_instance_of(Jpdate)
      end

      it "month is not Integer" do
        expect{ Jpdate.new("M", 1, "1", 1) }.
          to raise_error(ArgumentError, Jpdate::MONTH_TYPE_ERROR_STRING)
      end

      it "month is less than 1" do
        expect{ Jpdate.new("M", 1, 0, 1) }.
          to raise_error(ArgumentError, Jpdate::MONTH_VALUE_ERROR_STRING)
      end

      it "month is more than 12" do
        expect{ Jpdate.new("M", 1, 13, 1) }.
          to raise_error(ArgumentError, Jpdate::MONTH_VALUE_ERROR_STRING)
      end

      it "month is more than or equal to 1 and less than or equal to 12" do
        expect(Jpdate.new("M", 1, 12, 1)).to be_an_instance_of(Jpdate)
      end

      it "day is not Integer" do
        expect{ Jpdate.new("M", 1, 1, "1") }.
          to raise_error(ArgumentError, Jpdate::DAY_TYPE_ERROR_STRING)
      end

      it "day is less than 1" do
        expect{ Jpdate.new("M", 1, 1, 0) }.
          to raise_error(ArgumentError, Jpdate::DAY_VALUE_ERROR_STRING)
      end

      it "day is more than 31" do
        expect{ Jpdate.new("M", 1, 12, 32) }.
          to raise_error(ArgumentError, Jpdate::DAY_VALUE_ERROR_STRING)
      end

      it "day is more than or equal to 1 and less than or equal to 31" do
        expect(Jpdate.new("M", 1, 1, 15)).to be_an_instance_of(Jpdate)
      end
    end
  end
end
