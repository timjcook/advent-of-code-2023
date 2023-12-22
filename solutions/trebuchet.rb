# frozen_string_literal: true

#  calculates calibration score for the trebuchet
class Trebuchet
  class << self
    def calculate(input:, part: 1)
      trebuchet = new(input: input)

      if part == 1
        trebuchet.part_1
      else
        trebuchet.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    input.map do |line|
      calibration_line_score(line: line)
    end.sum
  end

  def part_2
    input.map do |line|
      line = normalize_line(line: line.dup)
      calibration_line_score(line: line)
    end.sum
  end

  private

  def normalize_line(line:)
    line.chars.reduce('') do |acc, char|
      acc = acc + char

      [
        { label: 'one', value: 1 },
        { label: 'two', value: 2 },
        { label: 'three', value: 3 },
        { label: 'four', value: 4 },
        { label: 'five', value: 5 },
        { label: 'six', value: 6 },
        { label: 'seven', value: 7 },
        { label: 'eight', value: 8 },
        { label: 'nine', value: 9 },
        { label: 'zero', value: 0 }
      ].each do |num|
        acc.gsub!(num[:label], num[:value].to_s + num[:label][1..])
      end

      acc
    end   
  end

  def calibration_line_score(line:)
    chars = line.chars
    first = nil
    last = nil


    chars.each do |char|
      if char.match?(/\d/)
        first = char if first.nil?
        last = char
      end
    end

    last = first if last.nil?

    (first.to_s + last.to_s).to_i
  end
end