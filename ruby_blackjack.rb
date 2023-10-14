# https://jedi.mycohort.download/second-language/week-19/day-3/labs/ruby-blackjack/
# ! Init Game  puts 'Welcome to ruby blackjack!'
require "./Card.rb"
require "./Player.rb"
require "./Dealer.rb"
require "./Game.rb"

  puts 'Please enter your name'
  human_name = gets.chomp
  # puts "Hello, #{human_name}! How many decks would you like to play with?"
  # deck_num = gets.chomp.to_i + 1
  
  human = Human.new human_name, 1000
  house = Computer.new
  dealer = Dealer.new(deck_count = 99 )
  game = Game.new human, house , dealer

  # game.deck.each { |e| puts "#{e.suit}, #{e.value}, #{e.face}" }
  
  puts 'Enter (d) to play a round. Enter (q) at any time to quit.'
  
  cmd = ''
  while cmd != 'q'
    # puts "remaining in deck: #{game.deck.length}, remaining packs: #{game.num_decks}"
    cmd = gets.chomp
    if (cmd == 'd') && !game.in_round
      game.start_round()
      game.swap_anti
      puts ''
      puts "#{human.name} bets $10. bankroll = $#{human.bankroll}"
      puts "#{house.name} holds bet. bankroll = $#{house.bankroll}"
      game.deal
  
      puts "#{human.name}'s Hand: "
      human.print_hand
      human_sum = human.sum_hand
      puts "#{human.name}'s Sum: #{human_sum}"
  
      puts "#{house.name}'s First Card: "
      house.print_first
      house_sum = house.sum_hand
  
      if (human_sum == 21) && (house_sum == 21)
        puts 'Blackjacks for everyone!'
        puts "#{house.name}'s Hidden Card: "
        house.print_second
        in_round = false
        game.round_winner = 'tie'
        game.balance_tie
        game.end_round
        next
      elsif human_sum == 21
        puts 'You got Blackjack!'
        in_round = false
        game.round_winner = human.name
        game.reward_human
        game.end_round
        next
      elsif house_sum == 21
        puts 'Dealer dealt themselves Blackjack :('
        puts "#{house.name}'s Hidden Card: "
        house.print_second
        in_round = false
        game.round_winner = house.name
        game.end_round
      else
        puts 'hit (h) or stay (s)?'
      end
    elsif (cmd == 's') && game.in_round
      puts 'you have decided to stay'
  
      puts "#{human.name}'s Hand: "
      human.print_hand
      human_sum = human.sum_hand
      puts "#{human.name}'s Sum: #{human_sum}"
      puts "#{house.name}'s Hand: "
      house.print_hand
      house_sum = house.sum_hand
      puts "#{house.name}'s Sum: #{house_sum}"
  
      while house_sum < 17
        house.request_deal(dealer)
        house_sum = house.sum_hand
        puts "#{house.name} hits. Hand: "
        house.print_hand
        puts "#{house.name}'s Sum: #{house_sum}"
      end
  
      if house_sum > 21
        puts "#{house.name} busts at #{house_sum}!"
        game.round_winner = human.name
        game.reward_human
        game.end_round
        game.in_round = false
        next
      else
        puts "#{house.name} must stand at #{house_sum}"
      end
  
      if human_sum == house_sum
        game.round_winner = 'tie'
        game.balance_tie
      end
      if human_sum > house_sum
        game.round_winner = human.name
        game.reward_human
      end
      game.round_winner = house.name if human_sum < house_sum
      game.end_round
      game.in_round = false
  
    elsif (cmd == 'h') && game.in_round
      puts 'you have decided to hit'
      human.request_deal(dealer)
  
      puts "#{human.name}'s Hand: "
      human.print_hand
      human_sum = human.sum_hand
      puts "#{human.name}'s Sum: #{human_sum}"
  
      puts "#{house.name}'s First Card: "
      house.print_first
      house_sum = house.sum_hand

      game.check_win()

    
  
    elsif cmd != 'q'
      puts 'invalid input'
    end
  end
  puts 'game over'
