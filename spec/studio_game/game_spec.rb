require_relative 'spec_helper'
require 'studio_game/game'
require 'studio_game/game_turn'

module StudioGame
  describe Game do
  
    before do
      @game = Game.new("Knuckleheads")
  
      @initial_health = 100
      @player = Player.new("moe", @initial_health)
  
      @game.add_player(@player)
    end
  
    it "increases health with a high roll(5 or 6)" do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)
      @game.play(2)
      @player.health.should == @initial_health + (15 * 2)
    end
  
    it "skips health modification with a medium roll(3 or 4)" do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)
      @game.play(2)
      @player.health.should == @initial_health
    end
  
    it "decreases health with a low roll(1 or 2)" do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)
      @game.play(2)
      @player.health.should == @initial_health - (10 * 2)
    end
  
    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")
      game.add_player(player)
      game.play(1)
      player.points.should_not be_zero
    end
  
    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")
    
      player1 = Player.new("moe")
      player2 = Player.new("larry")
    
      game.add_player(player1)
      game.add_player(player2)
    
      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))
    
      game.total_points.should == 500
    end
  end
end