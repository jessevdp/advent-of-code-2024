require "./spec_helper"

describe StoneSet do
  describe "#evolve" do
    it "evolves all Stones once" do
      set = StoneSet.new([Stone.new(125), Stone.new(17)])

      set.evolve
      set.stones.should eq([
        Stone.new(253000),
        Stone.new(1),
        Stone.new(7),
      ])

      set.evolve
      set.stones.should eq([
        Stone.new(253),
        Stone.new(0),
        Stone.new(2024),
        Stone.new(14168),
      ])

      set.evolve
      set.stones.should eq([
        Stone.new(512072),
        Stone.new(1),
        Stone.new(20),
        Stone.new(24),
        Stone.new(28676032),
      ])

      set.evolve
      set.stones.should eq([
        Stone.new(512),
        Stone.new(72),
        Stone.new(2024),
        Stone.new(2),
        Stone.new(0),
        Stone.new(2),
        Stone.new(4),
        Stone.new(2867),
        Stone.new(6032),
      ])

      set.evolve
      set.stones.should eq([
        Stone.new(1036288),
        Stone.new(7),
        Stone.new(2),
        Stone.new(20),
        Stone.new(24),
        Stone.new(4048),
        Stone.new(1),
        Stone.new(4048),
        Stone.new(8096),
        Stone.new(28),
        Stone.new(67),
        Stone.new(60),
        Stone.new(32),
      ])

      set.evolve
      set.stones.should eq([
        Stone.new(2097446912),
        Stone.new(14168),
        Stone.new(4048),
        Stone.new(2),
        Stone.new(0),
        Stone.new(2),
        Stone.new(4),
        Stone.new(40),
        Stone.new(48),
        Stone.new(2024),
        Stone.new(40),
        Stone.new(48),
        Stone.new(80),
        Stone.new(96),
        Stone.new(2),
        Stone.new(8),
        Stone.new(6),
        Stone.new(7),
        Stone.new(6),
        Stone.new(0),
        Stone.new(3),
        Stone.new(2),
      ])

      set = StoneSet.new([Stone.new(125), Stone.new(17)])
      25.times do
        set.evolve
      end
      set.stones.size.should eq(55312)
    end
  end
end

