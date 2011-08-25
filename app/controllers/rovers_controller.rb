class RoversController < ApplicationController
  before_filter :no_created_rover, :except => [:index, :create]
  before_filter :created_rover, :only => [:index, :create]
  before_filter :no_finished_rover, :only => :destroy
  before_filter :finished_rover, :only => :update
  before_filter :no_started_rover, :only => [:update, :destroy]
  before_filter :started_rover, :only => :update_instruction

  def index
    $height = 5
    $width = 7
  end

  def create
    @rover = Rover.new
    create_rover
    start @rover
    render 'go'
  end

  def update_instruction
    if params[:rover] && params[:rover][:instruction] != ''
      current_rover.instruction = params[:rover][:instruction].upcase
    else
      current_rover.instruction = 'error'
    end
    if current_rover.save
      redirect_to go_path
    else
      flash[:error] = "Instruction should not be blank and must contain 
                       only M, R and L commands!"
      render 'go'
    end
  end

  def update
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
    render 'go'
  end

  def destroy
    current_rover.destroy
    finish
    redirect_to root_path
  end

  private

    def created_rover
      render 'go' if created?
    end

    def no_created_rover
      redirect_to root_path unless created?
    end

    def no_finished_rover
      render 'go' unless finished?
    end

    def finished_rover
      redirect_to finish_path if finished?
    end

    def no_started_rover
      render 'go' if current_rover.instruction == ''
    end

    def started_rover
      render 'go' if started?
    end
end

