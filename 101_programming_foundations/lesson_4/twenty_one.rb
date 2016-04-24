require 'pry'

UPPER_VALUE = 21

# Methods

def initialize_deck
  suits = ['hearts', 'diamonds', 'clubs', 'spades']
  values = %w(2 3 4 5 6 7 8 9 10 jack queen king ace)

  suits.product(values)
end

def card_value(card, deck)
  card_value = card[1]
  if ("2".."10").include?(card_value)
    return card_value.to_i
  elsif %w(jack queen king).include?(card_value)
    return 10
  elsif card_value == "ace"
    if deck_value_without_ace(deck) + 11 > UPPER_VALUE # TODO: for multiple aces in one deck
      return 1
    else
      return 11
    end
  end
end

def deck_value_without_ace(deck)
  new_deck = deck.select { |card| card[1] != 'ace' }
  deck_value(new_deck)
end

def deck_value(deck)
  total_value = 0
  deck.each do |card|
    total_value += card_value(card, deck)
  end
  total_value
end

def deck_to_s(deck)
  deck_string = ""
  deck.each { |card| deck_string += card_to_s(card) + ", " }
  deck_string
end

def card_to_s(card)
  "[#{card[0]}, #{card[1]}]"
end

# Game flow Methods

def initial_deal!(deck, player, dealer)
  2.times do
    draw_card!(deck, player)
  end

  2.times do
    draw_card!(deck, dealer)
  end
end

def draw_card!(deck, player)
  player[:deck] << deck.delete_at(rand(deck.length))
end

def stay!(player)
  player[:stayed] = true
end

def determine_move_dealer!(deck, dealer)
  if deck_value(dealer[:deck]) >= (UPPER_VALUE - 4)
    puts "Dealer stayed"
    dealer[:stayed] = true
  else
    puts "Drawing card..."
    draw_card!(deck, dealer)
  end
end

def busted?(player)
  deck_value(player[:deck]) > UPPER_VALUE
end

def nearest_deck(player, dealer)
  player_distance = (deck_value(player[:deck]) - UPPER_VALUE).abs
  dealer_distance = (deck_value(dealer[:deck]) - UPPER_VALUE).abs
  if player_distance > dealer_distance
    dealer
  elsif player_distance < dealer_distance
    player
  elsif player_distance == dealer_distance
    nil
  end
end

def winner(player, dealer)
  if busted?(player)
    dealer
  elsif busted?(dealer)
    player
  else
    nearest_deck(player, dealer)
  end
end

# Display Methods

def display_own_deck(deck)
  puts "You have: #{deck_to_s(deck)}"
end

def display_dealer_deck(deck)
  puts "Dealer has #{card_to_s(deck[0])} and an unknown card"
end

# Main Program

loop do
  main_deck = []
  player = {
    name: "Guido",
    deck: [],
    stayed: false
  }
  dealer = {
    name: "Dealer",
    deck: [],
    stayed: false
  }

  main_deck = initialize_deck
  initial_deal!(main_deck, player, dealer)

  display_own_deck(player[:deck])
  display_dealer_deck(dealer[:deck])

  loop do
    puts "Draw a card or stay? (draw/stay)"
    answer = gets.chomp.downcase

    if answer.start_with?("d")
      draw_card!(main_deck, player)
      display_own_deck(player[:deck])

      if busted?(player)
        puts "You busted!"
        break
      end
    else
      player[:stayed] = true
      break
    end
  end

  if !busted?(player)
    puts "Dealer's turn"
    loop do
      puts "Dealer draws card"
      determine_move_dealer!(main_deck, dealer)
      break if busted?(dealer)
      break if dealer[:stayed]
    end
  end

  puts "#{player[:name]} has: #{deck_value(player[:deck])} points"
  puts "#{dealer[:name]} has: #{deck_value(dealer[:deck])} points"

  if !!winner(player, dealer)
    puts "#{winner(player, dealer)[:name]} wins!"
  else
    puts "It's a draw"
  end

  puts "Want to play again? (yes/no)"
  answer = gets.chomp.downcase
  break unless answer.start_with?("y")
  system("clear")
end
