# frozen_string_literal: true

#  calculates the number of steps to the goal
class MapPlot
  class << self
    def calculate(input:, part: 1)
      map_plot = new(input: input)

      if part == 1
        map_plot.part_1
      else
        map_plot.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    sequence, nodes = parse_input(input: input)

    current_nodes = nodes.select { |node| node[:start_node] }
    sequence_step = 0
    count = 0

    while !current_nodes.all? { |node| node[:end_node] }
      action = sequence[sequence_step]
      current_nodes = update_nodes(nodes: current_nodes, action: action)

      sequence_step = (sequence_step + 1) % sequence.length
      count += 1
    end

    count
  end

  def part_2
    sequence, nodes = parse_input(input: input, ghosts: true)

    current_nodes = nodes.select { |node| node[:start_node] }
    sequence_step = 0
    count = 0

    found_endpoint_indexes = []

    while found_endpoint_indexes.length < current_nodes.length
      action = sequence[sequence_step]
      current_nodes = update_nodes(nodes: current_nodes, action: action)

      sequence_step = (sequence_step + 1) % sequence.length
      count += 1

      current_nodes.each.with_index do |node, index|
        if node[:end_node] && !found_endpoint_indexes.find { |i| i == index }
          found_endpoint_indexes << {
            index: index,
            count: count
          }
        end
      end
    end

    found_endpoint_indexes.map { |i| i[:count] }.reduce(:lcm)
  end

  private

  def update_nodes(nodes:, action:)
    nodes.map do |node|
      if action == 'L'
        node[:left]
      else
        node[:right]
      end
    end
  end

  def parse_input(input:, ghosts: false)
    sequence = input[0].split('')
    nodes = input[1..].map do |line|
      unless line.empty?
        node, options = line.split(' = ')
        left, right = options.split(', ').map { |option| option.gsub(/[()]/, '') }
        {
          name: node,
          left: left,
          right: right,
          start_node: ghosts ? node.split('').last == 'A' : node == 'AAA',
          end_node: ghosts ? node.split('').last == 'Z' : node == 'ZZZ'
        }
      else
        nil
      end
    end.compact
    
    nodes = nodes.each do |node|
      node[:left] = nodes.find { |n| n[:name] == node[:left] }
      node[:right] = nodes.find { |n| n[:name] == node[:right] }
    end

    [sequence, nodes]
  end
end