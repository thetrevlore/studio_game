require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

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

    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found:"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

    1.upto(rounds) do |round_num|
      if block_given?
        break if yield
      end
      puts "\nRound #{round_num}:"
      
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def total_points
    @players.reduce(0) { |sum, player| sum += player.points }
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

    sorted_players.each do |player|
      puts "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end

    puts "\n#{title.capitalize} High Scores"
    sorted_players.each do |player|
      puts "#{player.name.ljust(20, '.')} #{player.score}"
    end

    puts "\n#{total_points} total points from treasures found"
  end

end
