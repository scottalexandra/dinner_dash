class Cart
  attr_reader :data

  def initialize(data)
    @data = data || Hash.new
  end
end
