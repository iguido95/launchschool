# Calculates monthly annuity of a loan
# eg. 100.000 loan_amount, 6% interest_percent_rate, 120 months
def calculate_annuity(loan_amount, interest_percent_rate, months)
  interest_rate = interest_percent_rate.to_f / 100.0
  monthly_interest_rate = interest_rate / 12.0

  numerator = monthly_interest_rate * loan_amount.to_f
  denominator = 1.0 - (1.0 + monthly_interest_rate) ** (-months)

  (numerator / denominator)
end

def prompt(message)
  puts "=> " + message
end

def get_valid_postive_float(message)
  user_input = nil
  loop do
    user_input = gets.chomp.to_f

    if user_input <= 0.0
      prompt(message)
    else
      break
    end
  end

  user_input
end

def get_loan_amount
  prompt("What is your total loan amount? eg. 125000.68")

  loan_amount = get_valid_postive_float("You have to enter a valid loan amount.
                                          Only (positive) numbers")
  loan_amount
end

def get_interest_rate
  prompt("What is the annual interest rate? eg. '6.5' for 6.5%")

  interest_rate = get_valid_postive_float("You have to enter a valid interest rate.
                                             Only (positive) numbers")
  interest_rate
end

def get_duration_in_months
  prompt("What is the loan duration in years? eg. 4 years")
  user_input = nil

  year_duration = get_valid_postive_float("You have to enter a valid year duration.
                                           Only (positive) numbers")

  month_duration = year_duration * 12.0
end

loop do
  prompt("Welcome to the loan calculator. Please provide the following details")

  loan_amount = get_loan_amount()
  interest_rate = get_interest_rate()
  duration = get_duration_in_months()

  annuity = calculate_annuity(loan_amount, interest_rate, duration)

  puts("-" * 35)
  prompt("Summary:")
  puts("-" * 35)
  puts(" *Loan\t\t#{sprintf("€ %#.2f", loan_amount)}")
  puts(" *Interest\t#{sprintf("%#.2f", interest_rate)}%")
  puts(" *Duration\t#{sprintf("%#.1f", duration)} Months")
  puts("-" * 35)
  puts(" *Monthly Annuity\t#{sprintf("€ %#.2f", annuity)}")
  puts("-" * 35)

  prompt("Do you want to calculate another loan? (y/n)")
  answer = gets.chomp.downcase
  if answer == "y"
    prompt("Resetting values ...")
    sleep(0.9)
  else
    prompt("Ok. Thanks for using this calculator")
    break
  end

end
