# frozen_string_literal: true

require_relative '../solutions/oasis'

RSpec.describe Oasis do
  it 'calculates the next sum of the oasis values for part 1' do
    expect(Oasis.calculate(input: [
      "0 3 6 9 12 15",
      "1 3 6 10 15 21",
      "10 13 16 21 30 45"
    ], part: 1)).to eq 114
  end

  it 'calculates the next sum of the oasis values for part 1' do
    expect(Oasis.calculate(input: [
      "0 3 6 9 12 15",
      "1 3 6 10 15 21",
      "10 13 16 21 30 45"
    ], part: 2)).to eq 2
  end
end