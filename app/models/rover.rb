class Rover < ActiveRecord::Base
  attr_accessible :instruction

  instruction_regex = /^(M*R*L*)*$/

  validates :instruction, :presence => true,
                          :format   => { :with => instruction_regex },
                          :length   => { :maximum => 20 }

  def self.authenticate_with_cookie(id)
    rover = find_by_id(id)
    rover ? rover : nil
  end
end
