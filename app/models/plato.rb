class Plato < ActiveRecord::Base
  has_one :rover, :dependent => :destroy

  before_create :init

  def init
    self.height = 5
    self.width = 7
  end

  def position
    { [self.rover.x_position, self.rover.y_position] => 1 }
  end

  def exist?(x, y)
    (x >= 0) && (x < self.width) && (y >= 0) && (y < self.height)
  end
end

