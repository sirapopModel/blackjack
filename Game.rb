require "./Card.rb"
require "./Player.rb"
require "./Dealer.rb"
# Game Class
class Game
    attr_reader :computer_dealer ,:human_player,:dealer , :in_round
    attr_writer :game_winner, :round_number , :round_winner ,:in_round
    def initialize(human, computer,dealer)
      @dealer = dealer
      @human_player = human
      @computer_dealer = computer

      @round_winner = 'none yet'
      @game_winner = 'none yet'
      @round_number = 0
      @in_round = false

      @dealer.compose_deck
    end
    def deal
      @human_player.empty_hand()
      @computer_dealer.empty_hand()
  
      cards_to_deal = 4
      dealing_to_house = true
      temp = @dealer.has_deck?
      while cards_to_deal.positive? && temp
        if @dealer.is_deck_out?
          @dealer.compose_deck
          redo
        end
        if dealing_to_house
          bottom_card = @dealer.deal_one()
          @computer_dealer.add_card(bottom_card)
        else
          bottom_card = @dealer.deal_one()
          @human_player.add_card(bottom_card)
        end
        dealing_to_house = !dealing_to_house
        cards_to_deal -= 1
      end
      puts 'No more cards left to deal' unless temp
    end
 
    def swap_anti
      @human_player.bankroll -= 10
      @computer_dealer.bankroll += 10
    end
  
    def balance_tie
      @human_player.bankroll += 10
      @computer_dealer.bankroll -= 10
    end
  
    def reward_human
      @computer_dealer.bankroll -= 20
      @human_player.bankroll += 20
    end
  
    def end_round
      puts "round winner: #{@round_winner}"
      puts "#{human_player.name}'s bankroll: $#{human_player.bankroll}."
      puts "#{computer_dealer.name}'s bankroll: $#{computer_dealer.bankroll}"
    end

    def start_round
      @in_round = true
    end
    def check_win()
      human_sum = @human_player.sum_hand
      house_sum = @computer_dealer.sum_hand
      if (human_sum == 21) && (house_sum == 21)
        @in_round = false
        @round_winner = 'tie'
        balance_tie
        end_round
        #next
      elsif human_sum == 21
        @in_round = false
        @round_winner = @human_player.name
        reward_human
        end_round
        #next
      elsif house_sum == 21
        @in_round = false
        @round_winner = @computer_dealer.name
        end_round
      elsif human_sum > 21
        puts "#{@human_player.name} busts!"
        @in_round = false
        @round_winner = @computer_dealer.name
        end_round
  
      else
        puts 'hit (h) or stay (s)?'
    end
  end
end