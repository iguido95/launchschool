VALID_CHOICES = %w(rock paper scissors lizard spock).freeze

user_score = 0
computer_score = 0

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first_choice, second_choice)
  (first_choice == 'scissors' && second_choice == 'paper') ||
    (first_choice == 'paper' && second_choice == 'rock') ||
    (first_choice == 'rock' && second_choice == 'lizard') ||
    (first_choice == 'lizard' && second_choice == 'spock') ||
    (first_choice == 'spock' && second_choice == 'scissors') ||
    (first_choice == 'scissors' && second_choice == 'lizard') ||
    (first_choice == 'lizard' && second_choice == 'paper') ||
    (first_choice == 'paper' && second_choice == 'spock') ||
    (first_choice == 'spock' && second_choice == 'rock') ||
    (first_choice == 'rock' && second_choice == 'scissors')
end

def abbreviation?(word)
  word.length == 1
end

def to_full_choice(abbreviation)
  full_choice = ''

  VALID_CHOICES.each do |choice|
    if abbreviation == 'S' #capital 'S' for Spock.
      full_choice = VALID_CHOICES[4] #Spock
      break #Don't need to iterate over the rest
    elsif choice.slice(0) == abbreviation.downcase
      full_choice = choice
      break
    end
  end

  full_choice
end

def purify_choice(input)
  if abbreviation?(input)
    to_full_choice(input)
  else
    input.downcase
  end
end

def display_results(user_choice, computer_choice)
  if win?(user_choice, computer_choice)
    prompt("*** You won! ***")
  elsif user_choice == computer_choice
    prompt("*** It's a draw! ***")
  else
    prompt("*** You lose! ***")
  end
end

def display_intermediate_score(score_p1, score_p2)
  puts("-" * 11 + " score " + "-" * 12)
  puts("* You: #{score_p1}")
  puts("* Computer: #{score_p2}")
  puts("-" * 30)
end

def display_end_game(score_p1, score_p2)
  if winner?(score_p1)
    prompt(" *** You won this game! Congratulations. ***")
  else
    prompt(" *** Too bad. The computer won. ***")
  end
end

def winner?(player_score)
  player_score == 5
end

def game_over?(score_p1, score_p2)
  winner?(score_p1) || winner?(score_p2)
end

loop do
  user_choice = ''
  loop do
    prompt("It's your turn. Choose: #{VALID_CHOICES.join(', ')}")
    user_choice = purify_choice(Kernel.gets().chomp()) #Allows for abbreviations

    break if VALID_CHOICES.include?(user_choice)
    prompt("'#{user_choice}' is not a valid choice. Try again.")
  end

  computer_choice = VALID_CHOICES.sample()

  Kernel.puts("You chose: '#{user_choice}'. Computer chose: '#{computer_choice}'")

  if win?(user_choice, computer_choice)
    user_score += 1
  elsif win?(computer_choice, user_choice)
    computer_score += 1
  end

  display_results(user_choice, computer_choice)
  display_intermediate_score(user_score, computer_score)

  break if game_over?(user_score, computer_score)
end

display_end_game(user_score, computer_score)

prompt("Thanks for playing! Hope to see you soon.")
