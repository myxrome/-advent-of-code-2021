# frozen_string_literal: true

def follow_course(input)
  input.inject([0, 0]) do |coordinate, command|
    x, d = *coordinate
    direction, val = *command.split(' ')
    val = val.to_i

    case direction
    when 'forward' then [x + val, d]
    when 'up' then [x, d - val]
    when 'down' then [x, d + val]
    else [x, d]
    end
  end.inject(1, :*)
end

input = File.readlines('input.txt')
p follow_course(input)
