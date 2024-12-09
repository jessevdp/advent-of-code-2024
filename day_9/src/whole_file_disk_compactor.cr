class WholeFileDiskCompactor < DiskCompactor
  def compact : Array(Disk::Block)
    files_to_consider = file_map.sort_by(&.id).reverse

    while files_to_consider.any?
      file = files_to_consider.shift
      gap = find_gap_of_size(file.size)

      next unless gap
      next if gap.start > file.start

      swap_file_into_gap(file, gap)
    end

    @blocks
  end

  private module BlockSequence
    abstract def indexes : Array(Int32)

    def size
      indexes.size
    end

    def start
      indexes.first
    end

    def end
      indexes.last
    end
  end

  private record Gap, indexes : Array(Int32) do
    include BlockSequence
  end

  private record File, id : Int32, indexes : Array(Int32) do
    include BlockSequence
  end

  private def swap_file_into_gap(file : File, gap : Gap)
    return unless gap.size >= file.size

    gap = Gap.new(gap.indexes.first(file.size))
    swap(file, gap)
  end

  private def swap(a : BlockSequence, b : BlockSequence)
    return unless a.size == b.size

    a.indexes.zip(b.indexes).each do |(a_index, b_index)|
      swap(a_index, b_index)
    end
  end

  private def swap(a_index : Int32, b_index : Int32)
    a = @blocks[a_index]
    @blocks[a_index] = @blocks[b_index]
    @blocks[b_index] = a
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

  private def find_gap_of_size(size)
    head = -1
    while head < @blocks.size
      gap = find_gap_after(head)
      break unless gap
      return gap if gap.size >= size
      head = gap.end
    end
  end

  private def find_gap_after(index)
    if gap_start = find_free_block_index_after(index)
      gap_end = (find_file_block_index_after(gap_start) || @blocks.size) - 1
      Gap.new((gap_start..gap_end).to_a)
    end
  end

  private def find_free_block_index_after(offset)
    @blocks.index(offset + 1, &.free?)
  end

  private def find_file_block_index_after(offset)
    @blocks.index(offset + 1, &.file?)
  end
end

