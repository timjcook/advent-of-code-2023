# frozen_string_literal: true

require_relative '../solutions/trebuchet'

RSpec.describe Trebuchet do
  it 'calculates the expected calibration score for part 1' do
    expect(Trebuchet.calculate(input: [
      '1abc2',
      'pqr3stu8vwx',
      'a1b2c3d4e5f',
      'treb7uchet'
    ], part: 1)).to eq 142
  end

  it 'calculates the expected calibration score for part 2' do
    expect(Trebuchet.calculate(input: [
      'two1nine',
      'eightwothree',
      'abcone2threexyz',
      'xtwone3four',
      '4nineeightseven2',
      'zoneight234',
      '7pqrstsixteen'
    ], part: 2)).to eq 281
  end
end