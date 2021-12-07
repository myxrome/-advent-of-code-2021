# frozen_string_literal: true

def fuel_consumption_pt1(input)
  target = median(input)
  input.map { |i| (target - i).abs }.sum
end

def fuel_consumption_pt2(input)
  average = (input.sum.to_f / input.length).round

  [average - 1, average, average + 1].map do |target|
    input.map { |i| fuel_for((target - i).abs) }.sum
  end.min
end

def fuel_for(distance)
  return 0 if distance.zero?

  (1..distance).inject(0, :+)
end

def median(array)
  return nil if array.empty?

  sorted = array.sort
  size = sorted.length
  center = size.even? ? (size - 1) / 2 : size / 2
  sorted[center]
end

input = File.readlines('input.txt', chomp: true).first.split(',').map(&:to_i)
pp fuel_consumption_pt1(input)
pp fuel_consumption_pt2(input)
