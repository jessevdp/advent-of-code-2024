class Disk
  property blocks : Array(Block)

  def initialize(@blocks)
  end

  def self.from_disk_map(raw_disk_map)
    DiskMapParser.new(raw_disk_map).parse
  end

  def compact(strategy : DiskCompactor.class)
    @blocks = strategy.new(@blocks).compact
  end

  def checksum
    @blocks
      .map_with_index { |block, index| index * block.checksum_value }
      .sum(0_i64)
  end
end

module Disk::Block
  abstract def checksum_value : Int32
  abstract def file? : Bool

  def free? : Bool
    !file?
  end
end

record Disk::FileBlock, file_id : Int32 do
  include Block

  def file? : Bool
    true
  end

  def checksum_value : Int32
    file_id
  end
end

record Disk::FreeBlock do
  include Block

  def file? : Bool
    false
  end

  def checksum_value : Int32
    0
  end
end

abstract class DiskCompactor
  def initialize(@blocks : Array(Disk::Block))
  end

  abstract def compact : Array(Disk::Block)
end

