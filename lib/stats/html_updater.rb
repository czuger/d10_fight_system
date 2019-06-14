module HtmlUpdater

  def add_lines_after( filename, anchor, lines_to_add )
    lines = nil
    File.open( filename ) do |file|
      lines = file.readlines

      anchor_position = nil
      lines.each_with_index do |l, i|
        # p l.strip
        if anchor == l.strip
          anchor_position = i
          break
        end
      end

      raise 'Unable to find anchor' unless anchor_position

      lines = lines.insert( anchor_position+1, lines_to_add ).flatten
    end

    File.open( filename, 'w' ) do |file|
      lines.each do |l|
        file.write l
      end
    end
  end

end