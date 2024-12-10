class WholeFileDiskCompactor < DiskCompactor
  def compact : Array(Disk::Block)
    files_to_consider = all_files.sort_by(&.id).reverse
    gaps = all_gaps

    while files_to_consider.any?
      file = files_to_consider.shift

      gap_index = gaps.index do |gap|
        (gap.size >= file.size) && (file.start > gap.start)
      end
      next unless gap_index

      gap = gaps[gap_index]
      remaining_gap = swap_file_into_gap(file, gap)

      if remaining_gap
        gaps[gap_index] = remaining_gap
      else
        gaps.delete_at(gap_index)
      end
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
    return gap unless gap.size >= file.size

    rightsized_gap = Gap.new(gap.indexes.first(file.size))
    remaining_gap = Gap.new(gap.indexes - rightsized_gap.indexes)

    swap(file, rightsized_gap)

    remaining_gap
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

  private def all_files
    file_block_indexes = Hash(Int32, Array(Int32)).new

    head = -1
    while head < @blocks.size
      head = find_file_block_index_after(head)
      break unless head
      file_id = @blocks[head].as(Disk::FileBlock).file_id

      file_block_indexes[file_id] ||= [] of Int32
      file_block_indexes[file_id] << head
    end

    file_block_indexes.map { |id, indexes| File.new(id, indexes) }
  end

  private def all_gaps
    gaps = [] of Gap

    head = -1
    while head < @blocks.size
      gap = find_gap_after(head)
      break unless gap
      head = gap.end + 1
      gaps << gap
    end

    gaps
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

