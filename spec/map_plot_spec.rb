# frozen_string_literal: true

require_relative '../solutions/map_plot'

RSpec.describe MapPlot do
  it 'calculates the number of steps to the goal for part 1 a)' do
    expect(MapPlot.calculate(input: [
      'RL',
      '',
      'AAA = (BBB, CCC)',
      'BBB = (DDD, EEE)',
      'CCC = (ZZZ, GGG)',
      'DDD = (DDD, DDD)',
      'EEE = (EEE, EEE)',
      'GGG = (GGG, GGG)',
      'ZZZ = (ZZZ, ZZZ)'
    ], part: 1)).to eq 2
  end

  it 'calculates the number of steps to the goal for part 1 b)' do
    expect(MapPlot.calculate(input: [
      'LLR',
      '',
      'AAA = (BBB, BBB)',
      'BBB = (AAA, ZZZ)',
      'ZZZ = (ZZZ, ZZZ)'
    ], part: 1)).to eq 6
  end

  it 'calculates the number of steps to the goal for part 2' do
    expect(MapPlot.calculate(input: [
      'LR',
      '',
      '11A = (11B, XXX)',
      '11B = (XXX, 11Z)',
      '11Z = (11B, XXX)',
      '22A = (22B, XXX)',
      '22B = (22C, 22C)',
      '22C = (22Z, 22Z)',
      '22Z = (22B, 22B)',
      'XXX = (XXX, XXX)'
    ], part: 2)).to eq 6
  end
end