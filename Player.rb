# Player Module
class Player
    attr_reader :name
    attr_accessor :bankroll, :hand
    def initialize(name, bankroll)
      @name = name
      @bankroll = bankroll
      @hand = []
    end
  
    def print_hand
      @hand.each { |e| puts e.print_card }
    end
  
    # :reek:FeatureEnvy
    def sum_hand
      sum = 0
      aces = @hand.select { |k| k.value == 11 }
  
      # add all non-aces first
      @hand.map do |c, _|
        c_val = c.value
        sum += c_val if c_val != 11
      end
      total = 0 

      aces.map do |a, _|
        a_val = a.value
        total = sum + a_val
        ace_value = (total > 21) ? (1) : a_val
        sum += ace_value
      end
      return sum
    end

    def request_deal(dealer)
      bottom_card = dealer.deal_one()
      @hand.push(bottom_card)
    end

    def add_card(bottom_card)
      @hand.push(bottom_card)
    end
    def empty_hand()
      @hand = []
    end
  end
  
  # Human Class extends PLayer
  class Human < Player
    attr_reader :wants_hit
  
    def initialize(name, bankroll)
      super
      @wants_hit = true
    end
  
    def stay
      @wants_hit = false
    end
  end
  
  # Computer Class extends PLayer
  class Computer < Player
    def initialize
      super 'the_house', 10_000
    end
    
    def print_first
      e = hand[0]
      puts e.print_card
    end
  
    def print_second
      e = hand[1]
      puts e.print_card
    end
  end