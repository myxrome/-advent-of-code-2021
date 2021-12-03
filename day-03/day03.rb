# frozen_string_literal: true

def normalize(input)
  input.map { |i| i.gsub(/\D+/, '').split('') }
end

def gamma(input)
  input.transpose.map do |column|
    column.group_by { |bit| bit }.max_by { |_, bits| bits.length }.first
  end
end

def epsilon(gamma)
  gamma.map { |bit| bit == '0' ? '1' : '0' }
end

def power_consumption(input)
  input = normalize(input)

  gamma = gamma(input)
  epsilon = epsilon(gamma)

  gamma.join.to_i(2) * epsilon.join.to_i(2)
end

input = File.readlines('input.txt')
pp power_consumption(input)
