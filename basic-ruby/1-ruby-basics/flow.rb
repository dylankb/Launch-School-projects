# 1. false
# 2. flase
# 3. false
# 4. true
# 5. true

# Excercise 2
def caps(stri)
  if stri.length > 10
    stri.upcase
  else
    stri
  end
end

# puts caps('Hello World')

Excercise 3

def what_number()
  puts "Enter a number between 1 and 100: "
  num = gets.chomp.to_i
  while num < 0 || num > 100 
    puts "Enter a number BETWEEN 1 and 100!: "
    num = gets.chomp.to_i
  end
  if num < 50
    puts "Less than 50"
  elsif num < 100
    puts "Greater than 50 and less than 100"
  else
    puts "100!"
  end
end

puts what_number()

#Excercise 5
def case_num(numb)
  case 
  when numb < 0
    puts "Less than zero!"
  when numb <= 50
    puts "Less than 50"
  when numb <= 100
    puts "Greater than 50 and less than 100"
  else
    puts "100 or greater"
  end
end

puts case_num(60)

#Excercise 6
    def equal_to_four(x)
      if x == 4
        puts "yup"
      else
        puts "nope"
      end
    end

    equal_to_four(5)