class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def add_listing(listing_id)
    @contents[listing_id.to_s] = 1
  end

  def remove_listing(listing_id)
    @contents[listing_id.to_s] = 0
  end

  def reset
    contents.clear
  end
end
