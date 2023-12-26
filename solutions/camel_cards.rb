# frozen_string_literal: true

#  calculates the winning bids for camel cards
class CamelCards
  class << self
    def calculate(input:, part: 1)
      camel_cards = new(input: input)

      if part == 1
        camel_cards.part_1
      else
        camel_cards.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    hands = input.map do |line|
      cards, bid = parse_line(line: line)

      distribution =  hand_distribution(cards: cards)

      {
        cards: cards,
        ranking: hand_ranking(cards: cards, distribution: distribution),
        bid: bid
      }
    end

    order_hands(hands: hands).map.with_index { |h, i| h[:bid] * (i + 1) }.sum
  end

  def part_2
    hands = input.map do |line|
      cards, bid = parse_line(line: line)
      distribution =  hand_distribution(cards: cards)

      {
        cards: cards,
        ranking: hand_ranking(cards: cards, distribution: distribution, jokers: true),
        bid: bid
      }
    end

    order_hands(hands: hands, jokers: true).map.with_index { |h, i| h[:bid] * (i + 1) }.sum
  end

  private

  def parse_line(line:)
    cards, bid = line.split(' ')
    cards = cards.split('')

    [cards, bid.to_i]
  end

  def hand_ranking(cards:, distribution:, jokers: false)
    if jokers && cards.any? { |c| c == 'J' }   
      non_jokers = cards.select { |c| c != 'J' }
      num_jokers = cards.select { |c| c == 'J' }.length

      permutations = (non_jokers + ['A']).repeated_permutation(num_jokers)

      permutations.map do |joker_permutation|
        hand_ranking(
          cards: non_jokers + joker_permutation,
          distribution: hand_distribution(cards: non_jokers + joker_permutation)
        )
      end.max
    else
      if (distribution.values.any? { |v| v == 5 })
        7 # 5 of a kind
      elsif (distribution.values.any? { |v| v == 4 })
        6 # 4 of a kind
      elsif (distribution.values.any? { |v| v == 3 }) 
        if distribution.values.any? { |v| v == 2 }
          5 # Full house
        else
          4 # 3 of a kind
        end
      elsif (distribution.values.any? { |v| v == 2 }) 
        if distribution.values.select { |v| v == 2 }.length == 2
          3 # 2 pair
        else
          2 # one pair
        end
      else
        1 # high card
      end
    end
  end

  def hand_distribution(cards:)
    distribution = {}

    cards.each do |c|
      if distribution[c].nil?
        distribution[c] = 1
      else
        distribution[c] += 1
      end
    end

    distribution
  end

  def order_hands(hands:, jokers: false)
    hands.sort do |a, b|
      compare_ranking = a[:ranking] <=> b[:ranking]

      if (compare_ranking != 0)
        compare_ranking 
      else
        c = nil

        (0..4).each do |i|
          compare_val = card_value(card: a[:cards][i], jokers: jokers) <=> card_value(card: b[:cards][i], jokers: jokers)

          if (compare_val != 0)
            c = compare_val 
            break
          end
        end

        c
      end
    end
  end

  def card_value(card:, jokers: false)
    value_map = {
      'A' => 13,
      'K' => 12,
      'Q' => 11,
      'J' => jokers ? 0 : 10,
      'T' => 9,
      '9' => 8,
      '8' => 7,
      '7' => 6,
      '6' => 5,
      '5' => 4,
      '4' => 3,
      '3' => 2,
      '2' => 1
    }

    value_map[card]
  end
end