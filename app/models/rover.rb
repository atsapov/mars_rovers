class Rover < ActiveRecord::Base
  instruction_regex = /[M,R,L]/

  validates :instruction, :presence => true,
                    	  :format   => { :with => instruction_regex }
end
