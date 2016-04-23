statement = "The Flintstones Rock"
letter_hash = {}

for index in 0..(statement.length - 1)
  character = statement[index]

  if letter_hash[character]
    letter_hash[character] += 1
  else
    letter_hash[character] = 1
  end
end

p letter_hash
