# frozen_string_literal: true

def normalize(input)
  input.map do |line|
    line.split(' -> ').map do |coordinate|
      coordinate.split(',').map(&:to_i)
    end
  end
end

def filter_lines(lines)
  lines.select do |line|
    start, finish = *line
    start.first == finish.first || start.last == finish.last
  end
end

def diagram(lines)
  lines.each_with_object({}) do |line, result|
    x1, y1, x2, y2 = *line.flatten
    dx = (x2 - x1) <=> 0
    dy = (y2 - y1) <=> 0
    length = [(x1 - x2).abs, (y1 - y2).abs].max

    (0..length).each do |step|
      x = step * dx + x1
      y = step * dy + y1
      result["#{x},#{y}"] ||= 0
      result["#{x},#{y}"] += 1
    end
  end
end

def points_with_overlap(diagram, threshold)
  diagram.select { |_, value| value > threshold }
end

def dangerous_area_count(input)
  input = normalize(input)
  lines = input #filter_lines(input)
  diagram = diagram(lines)
  points_with_overlap(diagram, 1).size
end

input = File.readlines('input.txt', chomp: true)
pp dangerous_area_count(input)
