class Cart
  attr_reader :data

  def initialize(data)
    @data = data || { "" => 0 }
  end

  def add_item(item_id)
    @data[item_id] ||= 0
    @data[item_id] += 1
  end
end
