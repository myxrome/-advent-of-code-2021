# frozen_string_literal: true

def increase_count(input)
  input.each_cons(2).sum { |left, right| left < right ? 1 : 0 }
end

input = File.readlines('input.txt').map(&:to_i)
p increase_count(input)
