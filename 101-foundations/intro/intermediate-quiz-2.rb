# Ex. 1
munsters = { 
  "Herman" => { "age" => 32, "gender" => "male" }, 
  "Lily" => { "age" => 30, "gender" => "female" }, 
  "Grandpa" => { "age" => 402, "gender" => "male" }, 
  "Eddie" => { "age" => 10, "gender" => "male" } 
}

sum = 0
munsters.select do |name, details|
  details["gender"] == "male"
  sum += details["age"]
end

# Ex. 2 - String substitution on multiple hashes
munsters.each do |name, details|
  puts "#{name} is a #{details["age"]} year old #{details["gender"]}"
end

# Ex. 4 
sentence = "Humpty Dumpty sat on a wall."
words = sentence.split(/\W/)
words.reverse!
words.join(" ") + "."
end

# Ex. 5

def mess_with_demographics(demo_hash)
  demo_hash.each do |family_member|
    puts family_member
  end
end

mess_with_demographics({
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
})
  