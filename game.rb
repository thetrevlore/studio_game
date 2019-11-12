require_relative 'player'
require_relative 'die'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play
    puts "There are #{@players.size} players in #{@title}:"
    @players.each do |player|
      puts player
    end
    @players.each do |player|
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
      puts player
    end
  end

end
