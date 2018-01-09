# Broken program
#
# class Book
#   def to_s
#     %("#{title}", by #{author})
#   end
# end
#
# book = Book.new
# book.author = "Neil Stephenson"
# book.title = "Snow Crash"
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

class Book
  attr_accessor :title, :author

  # def title=(new_title)  ## Alternative to attr_accessor
  #   @title = new_title
  # end
  #
  # def author=(new_author)
  #   @author = new_author
  # end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
