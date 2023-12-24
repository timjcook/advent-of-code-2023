# frozen_string_literal: true

#  calculates seed to location values
class Seeds
  class << self
    def calculate(input:, part: 1)
      seeds = new(input: input)

      if part == 1
        seeds.part_1
      else
        seeds.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    seeds, maps = parse_data

    seeds.map { |seed_range| seed_range.to_a }.flatten.map do |seed|
      run_from_seed(seed: seed, maps: maps)
    end.min
  end

  def part_2
    seeds, maps = parse_data(use_initial_seed_numbers: true)

    seams = [0, Float::INFINITY]

    maps.reverse.each do |map|
      endpoints = []
      sorted_ranges = map[:ranges].sort_by { |r| r[:source_range].first }

      endpoints.push(sorted_ranges.first[:source_range].begin - 1)
      sorted_ranges.each do |range|
        endpoints.push(range[:source_range].begin)
        endpoints.push(range[:source_range].end)
      end
      endpoints.push(sorted_ranges.last[:source_range].end + 1)
      
      endpoints = endpoints.sort.uniq.filter { |s| s >= 0 }

      seams = (endpoints + seams.map { |s| map[:source_fn].call(s) }).uniq.sort
    end

    seeds_within_range = (seams.select { |s| seeds.any? { |seed| s >= seed.begin && s < seed.end } })
    seed_endpoints = (seeds.flat_map { |s| [s.begin, s.end - 1] })

    seeds_to_test = (seeds_within_range + seed_endpoints).uniq.sort

    seeds_to_test.map do |seed|
      run_from_seed(seed: seed, maps: maps)
    end.min
  end

  private

  def run_from_seed(seed:, maps:)
    maps.reduce(seed) do |acc, map|
      map[:destination_fn].call(acc)
    end
  end

  def parse_data(use_initial_seed_numbers: false)
    seeds = []
    maps = []

    input.each do |row|
      if row.include?('seeds:')
        seeds = row.split(': ')[1].split(' ').map(&:to_i)

        if use_initial_seed_numbers
          seeds = seeds.each_slice(2).map do |s|
            (s[0]..s[0] + s[1])
          end
        else
          seeds = seeds.map do |s|
            (s..s)
          end
        end
      elsif row.include?('map:')
        source_type, destination_type = row.split(' ')[0].split('-to-')

        maps << {
          source_type: source_type,
          destination_type: destination_type,
          ranges: []
        }
      elsif row.match?(/\d/)
        destination, source, range = row.split(' ')

        maps.last[:ranges].push({
          source_range: (source.to_i..(source.to_i + range.to_i - 1)),
          destination_range: (destination.to_i..(destination.to_i + range.to_i - 1))
        })
      end
    end

    maps.map do |map|
      map[:destination_fn] = ->(s) do
        map[:ranges].each do |r|
          if r[:source_range].cover?(s)
            return r[:destination_range].first + (s - r[:source_range].first)
          end
        end

        s
      end

      map[:source_fn] = ->(d) do
        map[:ranges].each do |r|
          if r[:destination_range].cover?(d)
            return r[:source_range].first + (d - r[:destination_range].first)
          end
        end

        d
      end
    end

    [seeds, maps]
  end
end