module PlatosHelper

  def position_image(x, y)
    if @plato.position[[x, y]]
      rover_image
    else
      "nothing.png"
    end
  end

  def rover_image
    image_rules = {'E' => "rover_E.png",
                   'N' => "rover_N.png",
		   'W' => "rover_W.png",
		   'S' => "rover_S.png"}
    image_rules[@rover.direction]
 end
end

