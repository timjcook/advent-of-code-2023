# frozen_string_literal: true

require_relative 'input_reader'
require_relative 'solutions/trebuchet'

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