# frozen_string_literal: true

require_relative 'input_reader'
require_relative 'solutions/trebuchet'
require_relative 'solutions/bag_of_cubes'
require_relative 'solutions/engine_schematics'
require_relative 'solutions/scratchcards'
require_relative 'solutions/seeds'
require_relative 'solutions/boat_racing'
require_relative 'solutions/camel_cards'
require_relative 'solutions/map_plot'

def heading(day:)
  puts "===========================================\n"
  puts "Day #{day}\n"
  puts "===========================================\n\n"
end

## Day 1

heading day: 1

reader = InputReader.new(filename: 'inputs/day-1.txt')
score_1 = Trebuchet.calculate(input: reader.lines, part: 1)
score_2 = Trebuchet.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 2

heading day: 2

reader = InputReader.new(filename: 'inputs/day-2.txt')
score_1 = BagOfCubes.calculate(input: reader.lines, part: 1)
score_2 = BagOfCubes.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 3

heading day: 3

reader = InputReader.new(filename: 'inputs/day-3.txt')
score_1 = EngineSchematics.calculate(input: reader.lines, part: 1)
score_2 = EngineSchematics.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 4

heading day: 4

reader = InputReader.new(filename: 'inputs/day-4.txt')
score_1 = Scratchcards.calculate(input: reader.lines, part: 1)
score_2 = Scratchcards.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 5

heading day: 5

reader = InputReader.new(filename: 'inputs/day-5.txt')
score_1 = Seeds.calculate(input: reader.lines, part: 1)
score_2 = Seeds.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 6

heading day: 6

reader = InputReader.new(filename: 'inputs/day-6.txt')
score_1 = BoatRacing.calculate(input: reader.lines, part: 1)
score_2 = BoatRacing.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 7

heading day: 7

reader = InputReader.new(filename: 'inputs/day-7.txt')
score_1 = CamelCards.calculate(input: reader.lines, part: 1)
score_2 = CamelCards.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"

## Day 8

heading day: 8

reader = InputReader.new(filename: 'inputs/day-8.txt')
score_1 = MapPlot.calculate(input: reader.lines, part: 1)
score_2 = MapPlot.calculate(input: reader.lines, part: 2)

puts "Part 1: #{score_1}\n\n"
puts "Part 2: #{score_2}\n\n"