module DamageItem

  def damage_item
    if self.kind_of?( Tool )
      @hp -= 1
    end
  end

end