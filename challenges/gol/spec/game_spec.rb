require "spec_helper"

RSpec.describe Game do
  it "works" do
  end

  it "is an empty board" do
    game = Game.new
    expect(game.empty?).to eq true
  end

  it "can create a cell" do
    game = Game.new
    game.create_cell(1,2)
    expect(game.empty?).to eq false
  end

  it "can haz live cells" do
    game = Game.new
    game.create_cell(1, 1)
    game.enliven_cell(1, 1)

    expect(game.cell_at(1, 1)).to be_a(LiveCell)
  end

  it "can haz dead cells" do
    game = Game.new
    game.create_cell(1, 1)
    game.deaden_cell(1,1)

    expect(game.cell_at(1, 1)).to be_a(DeadCell)
  end

  it "will default to dead" do
    game = Game.new
    game.create_cell(1, 1)

    expect(game.cell_at(1, 1)).to be_a(DeadCell)
  end

  it "has many cells" do
    game = Game.setup(3, 3)
    expect(game.empty?).to eq(false)
  end

  it "can create a board with some live cells" do
    game = Game.setup(2, 2, [[1, 1], [2, 2]])

    expect(game.cell_at(1, 1)).to be_a(LiveCell)
    expect(game.cell_at(1, 2)).to be_a(DeadCell)
    expect(game.cell_at(2, 1)).to be_a(DeadCell)
    expect(game.cell_at(2, 2)).to be_a(LiveCell)
  end
end
