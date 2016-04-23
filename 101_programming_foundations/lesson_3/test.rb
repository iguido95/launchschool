advice = "Few things in life are as important as house training your pet dinosaur."

words = advice.split(' ')

p words

words.each do |word|
  if word == 'important'
    word.replace('urgent')
  end
end

advice = words.join(' ')

puts advice




## Question 6

famous_words = "seven years ago..."
famous_words = "Four score and " + famous_words

famous_words = "seven years ago..."
famous_words.prepend("Four score and ")
