class Matrix

  def initialize(points)
    @data_points = matrix_string_to_matrix_array(points)
  end

  def rows
    @data_points
  end

  def columns
    @data_points.transpose
  end

  def saddle_points
    col_mins = columns.each_with_object([]) { |col, acc| acc << col.min }
    row_maxs = rows.each_with_object([]) { |row, acc| acc << row.max }

    row_maxs.each_with_object([]).with_index do |(num, obj), index|
      obj << [index, col_mins.find_index(num)] if col_mins.include?(num)
    end
  end

  private

  def matrix_string_to_matrix_array(points)
    points.split("\n").map { |string| string.split(" ").map(&:to_i) }
  end

end