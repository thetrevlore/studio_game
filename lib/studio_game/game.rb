# require 'csv'
require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

module StudioGame  
  class Game
    attr_reader :title
    def initialize(title)
      @title = title
      @players = []
    end
  
    def add_player(player)
      @players << player
    end
  
    def load_players(from_file)
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
      # CSV.foreach(from_file) do |row|
      #   player = Player.new(row[0], Integer(row[1]))
      #   add_player(player)
      # end
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
        puts high_score_entry(player)
      end
  
      puts "\n#{total_points} total points from treasures found"
    end
  
    def save_high_scores(to_file="high_scores.txt")
      sorted_players = @players.sort
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        sorted_players.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end
  
    def high_score_entry(player)
      "#{player.name.ljust(20, '.')} #{player.score}"
    end
  
  end
end
