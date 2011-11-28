class RoversController < ApplicationController
  before_filter :correct_rover
  before_filter :started_rover, :only => :edit

  def edit
  end

  def update
    if @rover.update_attributes(params[:rover])
      redirect_to go_path
    else
      render 'edit'
    end
  end

  def go
    @rover.go
    render 'go'
  end

  private

    def started_rover
      redirect_to go_path if started?
    end

    def correct_rover
      redirect_to root_path unless find_rover && current_rover?(@rover)
    end

    def find_rover
      @plato = @rover.plato if @rover = Rover.find_by_id(params[:id])
    end
end

