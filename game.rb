require_relative 'player'
require_relative 'die'
require_relative 'game_turn'

class Game
  attr_reader :title
  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def play(rounds)
    puts "There are #{@players.size} players in #{@title}:"

    @players.each do |player|
      puts player
    end

    1.upto(rounds) do |round_num|
      puts "\nRound #{round_num}:"
      
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def print_players_stats(strength, players)
    puts "\n#{players.size} #{strength} players:"
    players.each do |player|
      puts "#{player.name} (#{player.health})"
    end
  end

  def print_stats
    sorted_players = @players.sort
    # sorted_players = @players.sort { |a, b| b.score <=> a.score }
    strongs, wimpys = sorted_players.partition { |p| p.strong? }

    puts "\n#{@title.capitalize} Statistics:"
    
    print_players_stats('strong', strongs)
    print_players_stats('wimpy', wimpys)

    puts "\n#{title.capitalize} High Scores"
    sorted_players.each do |player|
      puts "#{player.name.ljust(20, '.')} #{player.score}"
    end
  end

end
