# Card Class
class Card
    attr_reader :value,:suit, :face
        
    def initialize(value, suit, face)
      @value = value
      @suit = suit
      @face = face
    end

    def print_card()
      return "#{@value},#{@suit},#{@face}"
    end
  end