module RoversHelper
 
  def create_rover
    @rover.instruction = params[:rover] ? 
                         params[:rover][:instruction].upcase : ''
    @rover.h_plato = $height
    @rover.w_plato = $width
    @rover.plato = '0'*$height*$width
    @rover.x_position = (0..$width-1).to_a.shuffle[0]
    @rover.y_position = (0..$height-1).to_a.shuffle[0]
    @rover.direction = ['N','W','S','E'].shuffle[0]
    @rover.step = 0
    @rover.plato[@rover.y_position*$width+@rover.x_position] = '1'
  end

  def left
    @last_action = 'left'
      case current_rover.direction
      when "N"
        current_rover.direction = "W"
      when "W"
        current_rover.direction = "S"
      when "S"
        current_rover.direction = "E"
      when "E"
        current_rover.direction = "N"
      end
  end

  def right
    @last_action = 'right'
      case current_rover.direction
      when "N"
        current_rover.direction = "E"
      when "E"
        current_rover.direction = "S"
      when "S"
        current_rover.direction = "W"
      when "W"
        current_rover.direction = "N"
      end
  end

  def move
    @last_action = 'move'
    current_plato[current_rover.y_position][current_rover.x_position] = 0
      case current_rover.direction
      when "N"
        if current_rover.y_position < current_rover.h_plato-1
          current_rover.y_position += 1
        end
      when "W"
        if current_rover.x_position > 0
          current_rover.x_position -= 1
        end
      when "S"
        if current_rover.y_position > 0
          current_rover.y_position -= 1
        end
      when "E"
        if current_rover.x_position < current_rover.w_plato-1
          current_rover.x_position += 1
        end
      end
    current_plato[current_rover.y_position][current_rover.x_position] = 1
    save_plato
  end
end
