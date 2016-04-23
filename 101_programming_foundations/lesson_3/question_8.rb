def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times do
  how_deep.gsub!("number", "add_eight(number)")
end

p how_deep

p eval(how_deep)
