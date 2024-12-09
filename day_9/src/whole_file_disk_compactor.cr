class WholeFileDiskCompactor < DiskCompactor
  def compact : Array(Disk::Block)
    @blocks
  end
end

