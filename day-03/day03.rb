# frozen_string_literal: true

def normalize(input)
  input.map { |i| i.split('') }
end

# Part 1

def bits_to_number(bits)
  bits.inject(0) { |result, bit| (result << 1) | bit }
end

def power_consumption(input)
  input = normalize(input)

  gamma_bits = input.transpose.map do |column|
    column.group_by { |bit| bit }.max_by { |_, bits| bits.length }.first.to_i
  end
  epsilon_bits = gamma_bits.map { |bit| bit ^ 1 }

  bits_to_number(gamma_bits) * bits_to_number(epsilon_bits)
end

# Part 2

def find_criteria(partitions, function, default)
  if partitions.size > 1 && partitions.values.first.length == partitions.values.last.length
    default
  else
    partitions.send(function) { |_, bits| bits.length }.first
  end
end

def filter_criteria(input, index, function, default)
  partitions = input.transpose.at(index).group_by { |bit| bit }
  criteria = find_criteria(partitions, function, default)
  input.select { |row| row.at(index) == criteria }
end

def support_rating(input)
  input = normalize(input)

  ratings = (0..(input.first.length - 1)).inject([input, input]) do |current_ratings, index|
    oxygen, scrubber = *current_ratings
    [
      filter_criteria(oxygen, index, :max_by, '1'),
      filter_criteria(scrubber, index, :min_by, '0')
    ]
  end

  ratings.map { |rating| rating.join.to_i(2) }.inject(1, :*)
end

input = File.readlines('input.txt', chomp: true)
pp power_consumption(input)
pp support_rating(input)
