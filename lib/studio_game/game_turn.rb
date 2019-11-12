require_relative 'die'
require_relative 'loaded_die'
require_relative 'player'
require_relative 'treasure_trove'

module StudioGame
  module GameTurn
    def self.take_turn(player)
      die = Die.new
      # die = LoadedDie.new
      number_rolled = die.roll

      case number_rolled
        when 5..6
          player.w00t
        when 3..4
          puts "#{player.name} was skipped."
        when 1..2
          player.blam
      end
      player.found_treasure(TreasureTrove.random)
    end
  end
end