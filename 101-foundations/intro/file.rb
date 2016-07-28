#Excercise 1

def has_lab?(word)
  if /lab/.match(word)
    puts word
  else
    puts "No match"
  end
end

# Excercise 4

def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }



