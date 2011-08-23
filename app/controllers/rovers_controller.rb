class RoversController < ApplicationController
#  before_filter :new_rover,   :only => [:index, :create]
#  before_filter :started_rover, :only => [:update, :destroy]
#  before_filter :finished_rover, :only => :destroy

  def index
    $height = 5
    $width = 7
    @rover = Rover.new
  end

  def create
    @rover = Rover.new
    create_rover
    if @rover.save
      sign_in @rover
      render 'index'
    else
      flash[:error] = "Instruction should not be blank and must contain 
                       only M, R and L commands!"
      redirect_to root_path
    end
  end

  def update
    if current_rover.nil?
      redirect_to root_path
    else
      instruction = current_rover.instruction.split('')
      case instruction[current_rover.step]
      when "L"
        self.left
      when "R"
        self.right
      when "M"
        self.move
      end
      current_rover.step += 1
      current_rover.save
      render 'index'
    end
  end

  def destroy
    unless current_rover.nil?
      current_rover.destroy
      sign_out
    end
    redirect_to root_path
  end
end
