module SessionsHelper

  def start(rover)
    cookies.permanent.signed[:remember_token] = rover.id
    self.current_rover = rover
  end

  def current_rover=(rover)
    @current_rover = rover
  end

  def current_rover
    @current_rover ||= rover_from_remember_token
  end

  def started?
    !current_rover.nil?
  end

  def finished?
    current_rover.step >= current_rover.instruction.length
  end

  def current_plato
    @current_plato ||= plato_from_db
  end

  def save_plato
    current_rover.plato = current_plato.join
  end

  def finish
    cookies.delete(:remember_token)
    self.current_rover = nil
  end

  private

    def rover_from_remember_token
      Rover.authenticate_with_cookie(remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || nil
    end
  
    def plato_from_db
      plato = []
      0.upto(current_rover.h_plato-1) do |j|
        a = []
        0.upto(current_rover.w_plato-1) do |i|
          a << plato_from_str_to_a[j*current_rover.w_plato+i]
        end
        plato << a
      end
      plato
    end

    def plato_from_str_to_a
      current_rover.plato.split('').map{|k| k.to_i}
    end
end

