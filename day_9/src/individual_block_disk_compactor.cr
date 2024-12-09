class IndividualBlockDiskCompactor < DiskCompactor
  def compact : Array(Disk::Block)
    head = -1
    tail = @blocks.size
    while head < tail
      head = find_free_block_index_after(head)
      tail = find_file_block_index_before(tail)
      break unless head && tail
      break if head > tail
      swap(head, tail)
    end
    @blocks
  end

  private def swap(a_index, b_index)
    a = @blocks[a_index]
    @blocks[a_index] = @blocks[b_index]
    @blocks[b_index] = a
  end

  private def find_file_block_index_before(offset)
    @blocks.rindex(offset - 1, &.file?)
  end

  private def find_free_block_index_after(offset)
    @blocks.index(offset + 1, &.free?)
  end
end
