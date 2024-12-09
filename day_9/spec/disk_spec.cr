require "./spec_helper"

describe Disk do
  describe "#checksum" do
    it "calculates the checksum" do
      disk = Disk.from_disk_map("2333133121414131402")
      disk.compact
      disk.checksum.should eq(1928)
    end
  end

  describe "#compact" do
    it "fills up all free spaces in between file blocks by moving file blocks starting from the end" do
      disk = Disk.from_disk_map("2333133121414131402")
      disk.compact
      disk.blocks.should eq([
        Disk::FileBlock.new(file_id: 0),
        Disk::FileBlock.new(file_id: 0),
        Disk::FileBlock.new(file_id: 9),
        Disk::FileBlock.new(file_id: 9),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 1),
        Disk::FileBlock.new(file_id: 1),
        Disk::FileBlock.new(file_id: 1),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 2),
        Disk::FileBlock.new(file_id: 7),
        Disk::FileBlock.new(file_id: 7),
        Disk::FileBlock.new(file_id: 7),
        Disk::FileBlock.new(file_id: 3),
        Disk::FileBlock.new(file_id: 3),
        Disk::FileBlock.new(file_id: 3),
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 4),
        Disk::FileBlock.new(file_id: 4),
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 6),
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
      ])
    end
  end

  describe ".from_disk_map" do
    it "parses file & free blocks correctly" do
      disk = Disk.from_disk_map("2333133121414131402")
      disk.blocks.should eq([
        Disk::FileBlock.new(file_id: 0),
        Disk::FileBlock.new(file_id: 0),
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 1),
        Disk::FileBlock.new(file_id: 1),
        Disk::FileBlock.new(file_id: 1),
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 2),
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 3),
        Disk::FileBlock.new(file_id: 3),
        Disk::FileBlock.new(file_id: 3),
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 4),
        Disk::FileBlock.new(file_id: 4),
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FileBlock.new(file_id: 5),
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 6),
        Disk::FileBlock.new(file_id: 6),
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 7),
        Disk::FileBlock.new(file_id: 7),
        Disk::FileBlock.new(file_id: 7),
        Disk::FreeBlock.new,
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 8),
        Disk::FileBlock.new(file_id: 9),
        Disk::FileBlock.new(file_id: 9),
      ])
    end
  end
end
