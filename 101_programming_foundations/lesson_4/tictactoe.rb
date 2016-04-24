require 'pry'

EMPTY_MARK = ' '.freeze
PLAYER_MARK = 'X'.freeze
COMPUTER_MARK = 'Y'.freeze

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(array, separator=', ', last_word="or")
  joined_msg = ""

  array.each_with_index do |element, index|
    if index == (array.length - 1)
      joined_msg += " #{element}"
    else
      joined_msg += "#{element}" + separator
      joined_msg += last_word if index == (array.length - 2)
    end
  end

  joined_msg
end

def display_board(brd)
  system("clear")
  puts "You are a #{PLAYER_MARK}. Computer is a #{COMPUTER_MARK}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  for number in (1..9) do
    new_board[number] = EMPTY_MARK
  end
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == EMPTY_MARK }
end

def player_makes_move!(board)
  square = ''

  loop do
    prompt("Choose a square #{joinor(empty_squares(board))}")
    square = gets.chomp.to_i

    break if empty_squares(board).include?(square)
    prompt("That is not a valid square")
  end
  board[square] = PLAYER_MARK
end

def computer_makes_move!(board)
  square = empty_squares(board).sample()
  board[square] = COMPUTER_MARK
end

def board_full?(board)
  empty_squares(board).count == 0
end

def winner?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  winner = nil
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  winning_lines.each do |line|
    current_marker = ''
    counter = 0
    line.each do |tile|
      if current_marker == board[tile]
        counter += 1
      else
        current_marker = board[tile]
        counter = 1
      end
    end

    if counter == 3 && current_marker != EMPTY_MARK
      winner = current_marker
      break
    end
  end

  winner
end

def game_over?(board)
  winner?(board) || board_full?(board)
end

loop do
  board = initialize_board
  display_board(board)
  loop do
    display_board(board)

    player_makes_move!(board)
    break if game_over?(board)

    computer_makes_move!(board)
    break if game_over?(board)
  end

  display_board(board)
  puts "Game over"
  if board_full?(board) && !winner?(board)
    puts "It's a tie"
  else
    winner_name = detect_winner(board) == PLAYER_MARK ? "You" : "Computer"
    puts "#{winner_name} won!"
  end

  prompt("Do you want to play another game? (y/n)")
  answer = gets.chomp.downcase

  break unless answer.start_with?("y")
end

prompt("Goodbye!")
