# Titleize Method

require 'pry'

def titleize(string)
  str_array = string.split(' ')
  cap_str_array = str_array.each { |word| word.capitalize! }
  cap_str_array.join(' ')
end

puts titleize("de hond is weggelopen")
