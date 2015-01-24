class Cart
  attr_reader :data

  def initialize(data)
    @data = data || Hash.new
  end

  def add_item(item_id)
    @data[item_id] ||= 0
    @data[item_id] += 1
  end

  def count(data)
    data.values.reduce(0, :+)
  end

  def remove_item(item_id)
    @data[item_id] -= 1
  end
end
