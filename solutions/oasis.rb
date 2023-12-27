# frozen_string_literal: true

#  calculates future oasis values
class Oasis
  class << self
    def calculate(input:, part: 1)
      oasis = new(input: input)

      if part == 1
        oasis.part_1
      else
        oasis.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    lines = parse_input(input: input)

    lines.map do |line|
      generate_next_value(line: line)     
    end.sum
  end

  def part_2
    lines = parse_input(input: input)

    lines.map do |line|
      generate_previous_value(line: line)     
    end.sum
  end

  private

  def generate_previous_value(line:)
    changes = generate_history(line: line)

    changes.last.prepend(0)
    changes = changes.reverse

    changes.each.with_index do |c, i|
      unless i == 0
        c.prepend(c.first - changes[i - 1].first)
      end
    end

    changes.reverse[0].first
  end

  def generate_next_value(line:)
    changes = generate_history(line: line)

    changes.last << 0
    changes = changes.reverse

    changes.each.with_index do |c, i|
      unless i == 0
        c << c.last + changes[i - 1].last
      end
    end

    changes.reverse[0].last
  end

  def generate_history(line:)
    changes = [line]

    while changes.last.uniq != [0]
      prev_value = nil
      new_change = []

      changes.last.each do |c|
        new_change << c - prev_value unless prev_value.nil?
        prev_value = c
      end

      changes << new_change
    end

    changes
  end

  def parse_input(input:)
    input.map do |line|
      line.split(' ').map(&:to_i)
    end
  end
end