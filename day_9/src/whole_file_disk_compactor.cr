class WholeFileDiskCompactor < DiskCompactor
  def compact : Array(Disk::Block)
    initial_file_map = file_map
    @blocks
  end

  private record File, id : Int32, block_indexes : Array(Int32) do
    def size
      @block_indexes.size
    end
  end

  private def file_map
    files = [] of File

    file_ids = @blocks.select(Disk::FileBlock).map(&.file_id).to_set
    file_ids.map do |file_id|
      block_indexes = @blocks.each_with_index
        .select { |block, _| block.is_a?(Disk::FileBlock) }
        .map { |block, index| { block.as(Disk::FileBlock), index } }
        .select { |block, _| block.file_id == file_id }
        .map { |_, index| index }
        .to_a
      files << File.new(file_id, block_indexes)
    end

    files
  end
end

