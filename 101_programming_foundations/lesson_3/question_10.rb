flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones_hash = {}

flintstones.each_index do |i|
  name = flintstones[i]
  flintstones_hash[name] = i
end

p flintstones_hash
