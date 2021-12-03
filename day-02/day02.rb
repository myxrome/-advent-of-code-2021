# frozen_string_literal: true

def follow_course(input)
  input.inject([0, 0, 0]) do |coordinate, command|
    x, d, aim = *coordinate
    direction, val = *command.split(' ')
    val = val.to_i

    case direction
    when 'forward' then [x + val, d + (aim * val), aim]
    when 'up' then [x, d, aim - val]
    when 'down' then [x, d, aim + val]
    else [x, d, aim]
    end
  end.take(2).inject(1, :*)
end

input = File.readlines('input.txt')
p follow_course(input)
