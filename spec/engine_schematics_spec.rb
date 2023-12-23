# frozen_string_literal: true

require_relative '../solutions/engine_schematics'

RSpec.describe EngineSchematics do
  it 'calculates the expected parts numbers for part 1' do
    expect(EngineSchematics.calculate(input: [
      '467..114..',
      '...*......',
      '..35..633.',
      '......#...',
      '617*......',
      '.....+.58.',
      '..592.....',
      '......755.',
      '...$.*....',
      '.664.598..'
    ], part: 1)).to eq 4361
  end

  it 'calculates the expected parts numbers for part 2' do
    expect(EngineSchematics.calculate(input: [
      '467..114..',
      '...*......',
      '..35..633.',
      '......#...',
      '617*......',
      '.....+.58.',
      '..592.....',
      '......755.',
      '...$.*....',
      '.664.598..'
    ], part: 2)).to eq 467835
  end
end