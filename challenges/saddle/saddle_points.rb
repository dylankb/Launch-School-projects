class Matrix

  def initialize(points)
    @points = points
  end

  def format_points
    s_points = @points.split("\n")
    s_points.map { |string| string.split(" ").map(&:to_i) }
  end

  def rows
    format_points
  end

  def columns
    format_points.transpose
  end

  def saddle_points
    col_mins = columns.each_with_object([]) { |col, acc| acc << col.min }
    row_maxs = rows.each_with_object([]) { |row, acc| acc << row.max }

    row_maxs.each_with_object([]).with_index do |(num, obj), index|
      obj << [index, col_mins.find_index(num)] if col_mins.include?(num)
    end

  end
end