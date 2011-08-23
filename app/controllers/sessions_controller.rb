class SessionsController < ApplicationController

  def create
    sign_in @rover
  end

  def destroy
    sign_out
  end
end

