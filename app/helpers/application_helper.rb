module ApplicationHelper

  def coordinate_image(position)
    image_tag(file(position), :class => "plato")
  end

  def file(position)
    if position == 0
      "nothing.png"
    else
      file_for_rover
    end
  end

  def file_for_rover
    case current_rover.direction
    when "N"
      "rover_N.png"
    when "W"
      "rover_W.png"
    when "S"
      "rover_S.png"
    when "E"
      "rover_E.png"
    end
  end
end
