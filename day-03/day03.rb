# frozen_string_literal: true

def normalize(input)
  input.map { |i| i.gsub(/\D+/, '').split('') }
end

def bits_to_number(bits)
  bits.inject(0) { |result, bit| (result << 1) | bit }
end

def power_consumption(input)
  gamma_bits = input.transpose.map do |column|
    column.group_by { |bit| bit }.max_by { |_, bits| bits.length }.first.to_i
  end
  epsilon_bits = gamma_bits.map { |bit| bit ^ 1 }

  bits_to_number(gamma_bits) * bits_to_number(epsilon_bits)
end

input = File.readlines('input.txt')
pp power_consumption(normalize(input))
