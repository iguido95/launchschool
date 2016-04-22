# ask the user for two numbers
# ask the user for the operation to perform
# perform the operation on the two numbers
# output the result

require 'yaml'
require 'pry'

ALL_MESSAGES = YAML.load_file('calculator_messages.yml')
MESSAGES = ALL_MESSAGES["en"]

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  number.to_i() != 0
end

def operation_to_message(operator)
  binding.pry

  case operator
  when "1"
    MESSAGES["op_adding"]
  when "2"
    MESSAGES["op_subtracting"]
  when "3"
    MESSAGES["op_multiplying"]
  when "4"
    MESSAGES["op_dividing"]
  else
    ""
  end
end


loop do
  puts "What is your language? Wat is jouw taal? (en/nl)"
  answer = gets.chomp.downcase

  if answer == "nl"
    MESSAGES = ALL_MESSAGES["nl"]
    break
  else
    MESSAGES = ALL_MESSAGES["en"]
    break
  end
end

prompt(MESSAGES["welcome"])

loop do
  number1 = nil
  loop do
    prompt(MESSAGES["ask_first_number"])
    number1 = Kernel.gets().chomp().to_i()
    if valid_number?(number1)
      break
    else
      prompt(MESSAGES["is_no_number"])
    end
  end

  number2 = nil
  loop do
    prompt("#{MESSAGES["alright"]}, #{number1}. #{MESSAGES["great_choice"]}")
    prompt(MESSAGES["ask_second_number"])
    number2 = Kernel.gets().chomp().to_i()

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES["is_no_number"])
    end
  end

  prompt("Okay, Okay. #{number2}\n#{MESSAGES["what_operation"]} #{MESSAGES["choose_message"]}\n" +
              MESSAGES["operation_list"])
  operator = nil
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES["wrong_choose_message"] + "\n" + MESSAGES["operation_list"])
    end
  end

  result =  case operator
            when "1"
              number1 + number2
            when "2"
              number1 - number2
            when "3"
              number1 * number2
            when "4"
              number1.to_f() / number2.to_f()
            end

  prompt(MESSAGES["calculating"])
  sleep(0.5)
  prompt("#{operation_to_message(operator)}")
  sleep(0.9)
  prompt("Your answer is: #{result}")

  prompt(MESSAGES["another_calculation"] + " (" + MESSAGES["another_calculation_yes"] +
          "/" + MESSAGES["another_calculation_no"] + ")")
  answer = Kernel.gets().chomp().downcase

  if answer == MESSAGES["another_calculation_yes"]
    prompt(MESSAGES["another_calculation_message"])
  else
    prompt(MESSAGES["no_calculation_message"])
    break
  end
end
