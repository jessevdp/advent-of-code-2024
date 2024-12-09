class Disk
  property blocks : Array(Block)

  def initialize(@blocks)
  end

  def self.from_disk_map(raw_disk_map)
    DiskMapParser.new(raw_disk_map).parse
  end
end

module Disk::Block
end

record Disk::FileBlock, file_id : Int32 do
  include Block
end

record Disk::FreeBlock do
  include Block
end

