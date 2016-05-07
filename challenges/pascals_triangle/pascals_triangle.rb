class Triangle

  def initialize(levels)
    @levels = levels
  end

  def rows
    (@levels - 1).times.with_object([[1]]) do |i, rows|
      last_row = create_row(rows[i])  
      rows << last_row
    end
  end
end

private

def self.create_row(last_row)
  new_row = []
  last_row.each_with_index do |value, index|
    index == 0 ? new_row << 1 : new_row << (value + last_row[index - 1])
  end
  new_row << 1
end

