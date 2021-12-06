# frozen_string_literal: true

def initialize_state(initial)
  state = Array.new(9, 0)
  initial.each { |fish| state[fish] += 1 }
  state
end

def colony_size(initial, days)
  state = initialize_state(initial)

  days.times do
    creators = state.shift
    state[6] += creators
    state[8] = creators
  end
  state.sum
end

input = File.readlines('input.txt', chomp: true).first.split(',').map(&:to_i)
pp colony_size(input, 256)
