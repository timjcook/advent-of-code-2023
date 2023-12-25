# frozen_string_literal: true

require_relative '../solutions/boat_racing'

RSpec.describe BoatRacing do
  it 'calculates the product of the number of ways to win each race for part 1' do
    expect(BoatRacing.calculate(input: [
      'Time:      7  15   30',
      'Distance:  9  40  200'
    ], part: 1)).to eq 288
  end

  it 'calculates the product of the number of ways to win the race for part 2' do
    expect(BoatRacing.calculate(input: [
      'Time:      7  15   30',
      'Distance:  9  40  200'
    ], part: 2)).to eq 71503
  end
end