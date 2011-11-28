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

  def created?
    !current_rover.nil?
  end

  def started?
    current_rover.step > 0
  end

  def finish
    cookies.delete(:remember_token)
    self.current_rover = nil
  end

  def current_rover?(rover)
    rover == current_rover
  end

  private

    def rover_from_remember_token
      Rover.authenticate_with_cookie(remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || nil
    end
end

