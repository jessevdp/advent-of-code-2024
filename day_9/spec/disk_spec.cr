require "./spec_helper"

describe Disk do
  describe "#checksum" do
    describe "IndividualBlockDiskCompactor" do
      it "calculates the checksum" do
        disk = Disk.from_disk_map("2333133121414131402")
        disk.compact(IndividualBlockDiskCompactor)
        disk.checksum.should eq(1928)
      end
    end

    describe "WholeFileDiskCompactor" do
      it "calculates the checksum" do
        disk = Disk.from_disk_map("2333133121414131402")
        disk.compact(WholeFileDiskCompactor)
        disk.checksum.should eq(2858)
      end
    end
  end

  describe "#compact" do
    describe "WholeFileDiskCompactor" do
      it "fills up all free spaces in between file blocks by moving file blocks starting from the end" do
        disk = Disk.from_disk_map("2333133121414131402")
        disk.compact(WholeFileDiskCompactor)
        disk.blocks.should eq([
          Disk::FileBlock.new(file_id: 0),
          Disk::FileBlock.new(file_id: 0),
          Disk::FileBlock.new(file_id: 9),
          Disk::FileBlock.new(file_id: 9),
          Disk::FileBlock.new(file_id: 2),
          Disk::FileBlock.new(file_id: 1),
          Disk::FileBlock.new(file_id: 1),
          Disk::FileBlock.new(file_id: 1),
          Disk::FileBlock.new(file_id: 7),
          Disk::FileBlock.new(file_id: 7),
          Disk::FileBlock.new(file_id: 7),
          Disk::FreeBlock.new,
          Disk::FileBlock.new(file_id: 4),
          Disk::FileBlock.new(file_id: 4),
          Disk::FreeBlock.new,
          Disk::FileBlock.new(file_id: 3),
          Disk::FileBlock.new(file_id: 3),
          Disk::FileBlock.new(file_id: 3),
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
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
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
          Disk::FileBlock.new(file_id: 8),
          Disk::FileBlock.new(file_id: 8),
          Disk::FileBlock.new(file_id: 8),
          Disk::FileBlock.new(file_id: 8),
          Disk::FreeBlock.new,
          Disk::FreeBlock.new,
        ])
      end
    end

    describe "IndividualBlockDiskCompactor" do
      it "fills up all free spaces in between file blocks by moving file blocks starting from the end" do
        disk = Disk.from_disk_map("2333133121414131402")
        disk.compact(IndividualBlockDiskCompactor)
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
