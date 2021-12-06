# frozen_string_literal: true

def initialize_numbers(line)
  line.split(',').map(&:to_i)
end

def initialize_boards(lines)
  lines.each_with_object([[]]) do |line, boards|
    if line == ''
      boards.push([])
      next boards
    end

    current_board = boards.at(-1)
    current_board.push(line.split(' ').map { |n| { number: n.to_i, marked: false } })
  end
end

def mark_board_numbers(board, num)
  board.each do |line|
    line.each { |item| item[:marked] = true if item[:number] == num }
  end
end

def bingo_board?(board)
  board.any? { |line| line.all? { |item| item[:marked] } } ||
    board.transpose.any? { |line| line.all? { |item| item[:marked] } }
end

def sum_unmarked(board)
  board.flatten.reject { |item| item[:marked] }.sum { |item| item[:number] }
end

def first_final_score(numbers, boards)
  numbers.each do |num|
    boards.each do |board|
      mark_board_numbers(board, num)
      return sum_unmarked(board) * num if bingo_board?(board)
    end
  end
end

def last_final_score(numbers, boards)
  last_board = numbers.inject({ board: nil, num: nil }) do |result, num|
    boards = boards.map do |board|
      mark_board_numbers(board, num)
      if bingo_board?(board)
        result = { board: board, num: num }
        next
      end
      board
    end.compact

    result
  end

  sum_unmarked(last_board[:board]) * last_board[:num]
end

input = File.readlines('input.txt', chomp: true)

numbers = initialize_numbers(input.at(0))
first_boards = initialize_boards(input.drop(2))
last_boards = initialize_boards(input.drop(2))

pp first_final_score(numbers, first_boards)
pp last_final_score(numbers, last_boards)
