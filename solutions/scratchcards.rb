# frozen_string_literal: true

#  calculates scratchcard values
class Scratchcards
  class << self
    def calculate(input:, part: 1)
      scratchcards = new(input: input)

      if part == 1
        scratchcards.part_1
      else
        scratchcards.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    input.map do |line|
      card = parse_card(line: line)
      card[:winning_points]
    end.sum
  end

  def part_2
    cards = input.map do |line|
      parse_card(line: line)
    end

    lookup = {}
    cards.reduce(0) do |acc, card|
      unless lookup[card[:card_number]].nil?
        copies = lookup[card[:card_number]]
      else
        copies = generate_card_copies(cards: cards, card: card, lookup: lookup)
        lookup[card[:card_number]] = copies
      end

      acc + copies.length + 1
    end
  end

  private

  def generate_card_copies(cards:, card:, lookup:)
    copies = []

    if (card[:num_winning_numbers] > 0)
      (1..card[:num_winning_numbers]).to_a.map do |num|
        found_card = cards.find { |c| c[:card_number] == card[:card_number] + num }
        copies.push(found_card) if found_card
      end
    end

    copies.compact.each do |copy|
      unless lookup[copy[:card_number]].nil?
        copies.push(lookup[copy[:card_number]])
      else
        copies.push(generate_card_copies(cards: cards, card: copy, lookup: lookup))
      end
    end

    lookup[card[:card_number]] = copies.flatten

    copies.flatten
  end
  
  def parse_card(line:)
    card_number, numbers = line.split(':')

    card_number = card_number.split.last.to_i

    winning_numbers, chosen_numbers = numbers.split('|')
    winning_numbers = winning_numbers.split.map(&:to_i)
    chosen_numbers = chosen_numbers.split.map(&:to_i)

    num_winning_numbers = 0
    
    chosen_numbers.each do |chosen|
      num_winning_numbers += 1 if winning_numbers.include?(chosen)
    end

    winning_points = 0
    if num_winning_numbers > 0
      winning_points = 2 ** (num_winning_numbers - 1)
    end

    {
      card_number: card_number,
      num_winning_numbers: num_winning_numbers,
      winning_points: winning_points
    }
  end
end