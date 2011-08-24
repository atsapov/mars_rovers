class SessionsController < ApplicationController

  def create
    start @rover
  end

  def destroy
    finish
  end
end

