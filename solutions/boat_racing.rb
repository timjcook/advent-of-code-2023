# frozen_string_literal: true

#  calculates the number of ways to win the boat race
class BoatRacing
  class << self
    def calculate(input:, part: 1)
      boat_racing = new(input: input)

      if part == 1
        boat_racing.part_1
      else
        boat_racing.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    times = []
    records = []

    input.each do |line|
      type, values = line.split(":")

      if type == "Time"
        times = values.strip.split(' ').map(&:to_i)
      elsif type == "Distance"
        records = values.strip.split(' ').map(&:to_i)
      end
    end

    times.map.with_index do |time, index|
      record = records[index]

      number_of_records = num_records_for_time(time: time, record: record)
    end.reduce(1) do |acc, product|
      acc * product
    end
  end

  def part_2
    time = nil
    record = nil

    input.each do |line|
      type, values = line.split(":")

      if type == "Time"
        time = values.strip.split(' ').join('').to_i
      elsif type == "Distance"
        record = values.strip.split(' ').join('').to_i
      end
    end

    num_records_for_time(time: time, record: record)
  end

  private

  def num_records_for_time(time:, record:)
    range = (0..time)

    first_record_t = nil

    range.each do |t|
      r = race_fn(time, t)

      if r > record
        first_record_t = t
        break
      end
    end

    if time.odd?
      ((time / 2) - first_record_t + 1) * 2
    else
      ((time / 2) - first_record_t) * 2 + 1
    end
  end

  def race_fn(race_length, hold_time)
    (hold_time * 1) * (race_length - hold_time)
  end
end