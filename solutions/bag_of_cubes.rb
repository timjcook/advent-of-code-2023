# frozen_string_literal: true

#  calculates number of possible games
class BagOfCubes
  class << self
    def calculate(input:, part: 1)
      bag_of_cubes = new(input: input)

      if part == 1
        bag_of_cubes.part_1
      else
        bag_of_cubes.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    cubes = {
      red: 12,
      green: 13,
      blue: 14
    }

    impossible_game_ids = []
    possible_game_ids = []

    input.each do |line|
      result = parse_line(line: line)

      id = result[:id]

      result[:draws].each do |draw|
        draw.flatten.each do |d|
          if d[:count] > cubes[d[:colour]]
            impossible_game_ids.push(id)
            break
          end
        end
      end

      possible_game_ids.push(id) unless impossible_game_ids.include?(id)
    end

    possible_game_ids.sum
  end

  def part_2
    input.map do |line|
      result = parse_line(line: line)
      id = result[:id]

      min_cubes = {
        red: 0,
        green: 0,
        blue: 0
      }

      result[:draws].flatten.each do |d|
        min_cubes[d[:colour]] = d[:count] if d[:count] > min_cubes[d[:colour]]
      end

      min_cubes.values.reduce(1) { |total, number| total * number }
    end.sum
  end

  private

  def parse_line(line:)
    id, rest = line.split(':')
    id = id.split(' ').last.to_i

    {
      id: id,
      draws: rest.split(';').map do |draw|
        draw.split(',').map(&:strip).map do |d|
          count, colour = d.split(' ')
          { colour: colour.to_sym, count: count.to_i }
        end 
      end
    }
  end
end