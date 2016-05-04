class Rover < ActiveRecord::Base
  belongs_to :plato

  instruction_regex = /\A[MRL]+\z/

  validates :instruction, :format  => { :with => instruction_regex },
                          :length  => { :maximum => 20 },
			  :on      => :update

  before_create :init

  def init
    self.x_position = rand(7)
    self.y_position = rand(5)
    self.direction = ['N','W','S','E'].shuffle[0]
    self.step = 0
  end

  def go
    case action
    when "L"
      left
    when "R"
      right
    when "M"
      move
    end
    self.step += 1
    self.save
  end
  
  def self.authenticate_with_cookie(id)
    rover = find_by_id(id)
  end

  private

    def action
      self.instruction.split('')[self.step]
    end
  
    def left
      self.direction = Direction.previous(self.direction)
    end

    def right
      self.direction = Direction.next(self.direction)
    end

    def move
      if plato.exist?(*next_position)
        self.x_position, self.y_position = *next_position
      end
    end

    def next_position
      move_x, move_y = *Direction.move(self.direction)
      [self.x_position + move_x, self.y_position + move_y]
    end
end

