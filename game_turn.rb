require_relative 'die'
require_relative 'player'

module GameTurn
  def self.take_turn(player)
    die = Die.new
    number_rolled = die.roll
    # if number_rolled >= 5
    #   player.w00t
    # elsif number_rolled <= 2
    #   player.blam
    # else
    #   puts "#{player.name} was skipped."
    # end
    case number_rolled
      when 5..6
        player.w00t
      when 3..4
        puts "#{player.name} was skipped."
      when 1..2
        player.blam
    end
  end
end