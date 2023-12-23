# frozen_string_literal: true

#  calculates parts from the engine schematics
class EngineSchematics
  class << self
    def calculate(input:, part: 1)
      engine_schematics = new(input: input)

      if part == 1
        engine_schematics.part_1
      else
        engine_schematics.part_2
      end
    end
  end

  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def part_1
    part_numbers = []
    grid = gridify(input: input)   

    grid.each.with_index do |row, row_index|
      number = []
      borders_symbol = false

      row.each.with_index do |cell, column_index|
        if cell.match?(/\d/)
          number.push(cell)

          border_cells = adjacent_cells(grid: grid, row_index: row_index, column_index: column_index)

          unless border_cells.all? { |c| c == '.' || c.match?(/\d/) }
            borders_symbol = true
          end
        else
          if !number.empty? && borders_symbol
            part_numbers.push(number.uniq.first.to_i) 
          end

          number = []
          borders_symbol = false
        end
      end

      part_numbers.push(number.first.to_i) if !number.empty? && borders_symbol
    end

    part_numbers.sum
  end

  def part_2
    gear_ratios = []
    grid = gridify(input: input)   

    grid.each.with_index do |row, row_index|
      row.each.with_index do |cell, column_index|
        if cell.match(/\*/)
          border_cells = adjacent_cells(grid: grid, row_index: row_index, column_index: column_index)

          # bit of a hack, assumes the same number won't border a * cell
          bordering_numbers = border_cells.select { |c| c.match?(/\d/) }.uniq

          if bordering_numbers.length == 2
            gear_ratios.push(bordering_numbers[0].to_i * bordering_numbers[1].to_i)
          end
        end
      end
    end

    gear_ratios.sum
  end

  private

  def gridify(input:)
    grid = input.map do |row|
      row.split('').map do |cell|
        cell
      end
    end

    grid.map do |row|
      number = []
      row.each.with_index do |cell, index|
        if cell.match?(/\d/)
          number.push(cell)
        else
          unless number.empty?
            ((index - number.length)..(index - 1)).to_a.each do |i|
              row[i] = number.join
            end
          end

          number = []
        end
      end

      unless number.empty?
        ((row.length - number.length)..(row.length - 1)).to_a.each do |i|
          row[i] = number.join
        end
      end

      row
    end
  end

  def adjacent_cells(grid:, row_index:, column_index:)
    adjacent_row_indexes = [row_index - 1, row_index, row_index + 1].select { |r| r >= 0 && r < grid.length }
    adjacent_column_indexes = [column_index - 1, column_index, column_index + 1].select { |c| c >= 0 && c < grid[row_index].length }

    adjacent_row_indexes.map do |r|
      adjacent_column_indexes.map do |c|
        unless r == row_index && c == column_index
          grid[r][c]
        end
      end.compact
    end.flatten
  end
end