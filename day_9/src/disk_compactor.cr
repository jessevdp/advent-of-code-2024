class DiskCompactor
  def initialize(@blocks : Array(Disk::Block))
  end

  def compact
    @blocks.each_index do |index|
      next if @blocks[index].file?
      last_file_block_index = find_last_file_block_index
      break if index >= last_file_block_index
      swap(index, last_file_block_index)
    end
    @blocks
  end

  private def swap(a_index, b_index)
    a = @blocks[a_index]
    @blocks[a_index] = @blocks[b_index]
    @blocks[b_index] = a
  end

  private def find_last_file_block_index
    @blocks.rindex { |block| block.file? }.not_nil!
  end
end
