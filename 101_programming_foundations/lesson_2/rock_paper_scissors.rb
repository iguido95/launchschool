VALID_CHOICES = %w(rock paper scissors).freeze

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first_choice, second_choice)
  (first_choice == 'rock' && second_choice == 'scissors') ||
    (first_choice == 'paper' && second_choice == 'rock') ||
    (first_choice == 'scissors' && second_choice == 'paper')
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

loop do
  user_choice = ''
  loop do
    prompt("It's your turn. Choose: #{VALID_CHOICES.join(', ')}")
    user_choice = Kernel.gets().chomp().downcase()

    break if VALID_CHOICES.include?(user_choice)
    prompt("'#{user_choice}' is not a valid choice. Try again.")
  end

  computer_choice = VALID_CHOICES.sample()

  Kernel.puts("You chose: '#{user_choice}'. Computer chose: '#{computer_choice}'")

  display_results(user_choice, computer_choice)

  prompt("Do you want to play again? (y/n)")
  answer = Kernel.gets().chomp().downcase()
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing! Hope to see you soon.")
