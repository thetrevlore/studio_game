class Player
  attr_accessor :name
  attr_reader :health

  def initialize(name, health=100)
    @name = name.capitalize
    @health = health
  end

  def score
    @name.length + @health
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
  end

  def blam
    @health -= 10
    puts "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
  end
end

player1 = Player.new('moe')
player2 = Player.new('larry', 60)
player3 = Player.new('curly', 125)

players = [player1, player2, player3]

puts "There are #{players.size} players in the game:"

# players.each do |player|
#   puts player
# end

# players.pop
# players.push(Player.new('shemp', 90))

# players.each do |player|
#   player.w00t
#   player.blam
#   puts player
# end
