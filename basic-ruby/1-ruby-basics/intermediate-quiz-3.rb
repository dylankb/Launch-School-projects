# Ex. 5
# Simplify the method below
# def color_valid(color)
#   if color == "blue" || color == "green"
#     true
#   else
#     false
#   end
# end

def color_valid(color)
  color == "blue" || color == "green" ? true : false
end

# Even simpler...

def color_valid(color)
  color == "blue" || color == "green"
end