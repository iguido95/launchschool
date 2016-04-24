munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

total_age_males = 0


munsters.each do |key, value|
  total_age_males += value["age"] if value["gender"] == "male"
end

puts "Total male age: #{total_age_males}"
