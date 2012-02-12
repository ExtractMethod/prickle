class Symbol

  def like
    "contains(@#{self.to_s}, '<value>')"
  end
end
