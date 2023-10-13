require "./Card.rb"
class Dealer
    attr_reader :deck,:num_decks
    def initialize(num_decks)
        @deck = []
        @num_decks = num_decks
    end

    def compose_deck
        @num_decks -= 1
        empty_deck
        fill_deck
        shuffle_deck
    end

    def empty_deck
        @deck = []
    end

    # :reek:NestedIterators
    def fill_deck
        suits = %w[♠ ♥ ♦ ♣]
        num_array = (1..9)
        suits.each do |s|
          @deck.push(Card.new(11, s, '🂡'))
          num_array.each do |c|
            @deck.push(Card.new((c + 1), s, '#'))
          end
          @deck.push(Card.new(10, s, '🂫'))
          @deck.push(Card.new(10, s, '🂭'))
          @deck.push(Card.new(10, s, '🂮'))
        end
    end

    def shuffle_deck
        @deck = @deck.shuffle
    end

    def deal_one()
        bottom_card = @deck.shift #front array pop
        if bottom_card
            return bottom_card
        else
          puts 'no cards remaining. all decks used. now is probably a good time to (q)uit?'
        end
    end

    def has_deck?
        @num_decks.positive?
    end
    
    def is_deck_out?
        @deck.length.zero?
    end

end