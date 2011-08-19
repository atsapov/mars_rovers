class RoversController < ApplicationController

  def index
    $height = 5
    $width = 7
    $coordinates = Array.new($height).map{|a| a = Array.new($width){0}}
    @rover = Rover.new
  end

  def create
    @rover = Rover.new
    @rover.instruction = params[:rover][:instruction].upcase
    @rover.y_position = (0..$height-1).to_a.shuffle[0]
    @rover.x_position = (0..$width-1).to_a.shuffle[0]
    @rover.direction = ['N','W','S','E'].shuffle[0]
    @rover.step = 0
    if @rover.save
      $coordinates[@rover.y_position][@rover.x_position] = 1
      render 'index'
    else
      flash[:error] = "Instruction should not be blank and must contain 
      only M, R and L commands!"
      redirect_to root_path
    end
  end

  def update
    unless Rover.first.nil?
      @rover = Rover.last
      instruction = @rover.instruction.split('')
      case instruction[@rover.step]
      when "L"
        self.left
      when "R"
        self.right
      when "M"
        self.move
      end
      @rover.step += 1
      @rover.save
      render 'index'
    else
      redirect_to root_path
    end
  end

  def destroy
    unless Rover.first.nil?
      @rover = Rover.last
      @rover.destroy
    end
    redirect_to root_path
  end

  def left
    @title = 'left'
      case @rover.direction
      when "N"
        @rover.direction = "W"
      when "W"
        @rover.direction = "S"
      when "S"
        @rover.direction = "E"
      when "E"
        @rover.direction = "N"
      end
  end

  def right
    @title = 'right'
      case @rover.direction
      when "N"
        @rover.direction = "E"
      when "E"
        @rover.direction = "S"
      when "S"
        @rover.direction = "W"
      when "W"
        @rover.direction = "N"
      end
  end

  def move
    @title = 'move'
    $coordinates[@rover.y_position][@rover.x_position] = 0
      case @rover.direction
      when "N"
        if @rover.y_position < $height-1
          @rover.y_position += 1
        end
      when "W"
        if @rover.x_position > 0
          @rover.x_position -= 1
        end
      when "S"
        if @rover.y_position > 0
          @rover.y_position -= 1
        end
      when "E"
        if @rover.x_position < $width-1
          @rover.x_position += 1
        end
      end
    $coordinates[@rover.y_position][@rover.x_position] = 1
  end
end
