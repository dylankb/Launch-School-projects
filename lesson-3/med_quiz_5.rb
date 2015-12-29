# 1. Medium Quiz
# https://launchschool.com/lessons/263069da/assignments/3726

# munsters = { 
#   "Herman" => { "age" => 32, "gender" => "male" }, 
#   "Lily" => { "age" => 30, "gender" => "female" }, 
#   "Grandpa" => { "age" => 402, "gender" => "male" }, 
#   "Eddie" => { "age" => 10, "gender" => "male" } 
# }

# # My solution

# male_munsters = {}
# total_age = 0
# male_munsters = munsters.keep_if { |munster, info | info['gender'] == 'male' }
# male_munsters.each { |munster, detail| total_age += detail['age']  }
# print total_age

# # Book solution

# total_male_age = 0
# munsters.each do |name, details|
#   total_male_age += details["age"] if details["gender"] == "male"
# end

# 2. 

# munsters.each do |name, detail|
#   puts "#{name} is a #{detail['age']} year old #{detail['gender']}"
# end

# 3. 

# def add_method(a_string_param, an_array_param)
#   a_string_param += "rutabaga"
#   an_array_param += ["rutabaga"]

#   return a_string_param, an_array_param
# end

# my_string = "pumpkins"
# my_array = ["pumpkins"]
# add_method(my_string, my_array)

# puts "My string looks like this now: #{my_string}"
# puts "My array looks like this now: #{my_array}"

# 4. 
# sentence = "Humpty Dumpty sat on a wall."
# reverse = sentence.split(/\W/).reverse.join(" ")
# print reverse + ('.')

