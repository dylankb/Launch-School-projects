class Matrix

  def initialize(points)
    @points = points
  end

  def rows
    matrix_string_to_matrix_array
  end

  def columns
    matrix_string_to_matrix_array.transpose
  end

  def saddle_points
    col_mins = columns.each_with_object([]) { |col, acc| acc << col.min }
    row_maxs = rows.each_with_object([]) { |row, acc| acc << row.max }

    row_maxs.each_with_object([]).with_index do |(num, obj), index|
      obj << [index, col_mins.find_index(num)] if col_mins.include?(num)
    end
  end

  private

  def matrix_string_to_matrix_array
    @points.split("\n").map { |string| string.split(" ").map(&:to_i) }
  end

end