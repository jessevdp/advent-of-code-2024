class DiskMapParser
  def initialize(@raw_disk_map : String)
  end

  def parse
    blocks = [] of Disk::Block

    next_file_id = 0
    @raw_disk_map.chars.map(&.to_i).each_with_index do |count, index|
      if index.even?
        file_id = next_file_id
        next_file_id += 1
        count.times do
          blocks << Disk::FileBlock.new(file_id)
        end
      else
        count.times do
          blocks << Disk::FreeBlock.new
        end
      end
    end

    Disk.new(blocks)
  end
end
