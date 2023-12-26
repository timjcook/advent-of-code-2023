# frozen_string_literal: true

require_relative '../solutions/camel_cards'

RSpec.describe CamelCards do
  it 'calculates the total bids for part 1' do
    expect(CamelCards.calculate(input: [
      '32T3K 765',
      'T55J5 684',
      'KK677 28',
      'KTJJT 220',
      'QQQJA 483'
    ], part: 1)).to eq 6440
  end

  it 'calculates the total bids for part 2' do
    expect(CamelCards.calculate(input: [
      '32T3K 765',
      'T55J5 684',
      'KK677 28',
      'KTJJT 220',
      'QQQJA 483'
    ], part: 2)).to eq 5905
  end
end