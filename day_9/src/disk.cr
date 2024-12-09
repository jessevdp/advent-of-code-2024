class Disk
  property blocks : Array(Block)

  def initialize(@blocks)
  end

  def self.from_disk_map(raw_disk_map)
    DiskMapParser.new(raw_disk_map).parse
  end

  def compact
    @blocks = DiskCompactor.new(@blocks).compact
  end
end

module Disk::Block
  abstract def file? : Bool
end

record Disk::FileBlock, file_id : Int32 do
  include Block

  def file? : Bool
    true
  end
end

record Disk::FreeBlock do
  include Block

  def file? : Bool
    false
  end
end

