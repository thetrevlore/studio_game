require_relative 'spec_helper'
require_relative 'game'
require_relative 'game_turn'

describe Game do

  before do
    @game = Game.new("Knuckleheads")

    @initial_health = 100
    @player = Player.new("moe", @initial_health)

    @game.add_player(@player)
  end

  it "increases health with a high roll(5 or 6)" do
    allow_any_instance_of(Die).to receive(:roll).and_return(5)
    @game.play
    @player.health.should == @initial_health + 15
  end

  it "skips health modification with a medium roll(3 or 4)" do
    allow_any_instance_of(Die).to receive(:roll).and_return(3)
    @game.play
    @player.health.should == @initial_health
  end

  it "decreases health with a low roll(1 or 2)" do
    allow_any_instance_of(Die).to receive(:roll).and_return(1)
    @game.play
    @player.health.should == @initial_health - 10
  end
end