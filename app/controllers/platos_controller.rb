class PlatosController < ApplicationController
  before_filter :created_and_started_rover,
                :created_rover, :only => [:new, :create]
  before_filter :correct_plato, :only => :destroy

  def new
    @plato = Plato.new
  end

  def create
    @plato = Plato.create!
    @rover = @plato.create_rover
    start @rover
    redirect_to edit_rover_path(@rover)
  end

  def destroy
    @plato.destroy
    finish
    redirect_to root_path
  end

  private
   
    def created_and_started_rover
      redirect_to go_path(current_rover) if created? && started?
    end
   
    def created_rover
      redirect_to edit_rover_path(current_rover) if created?
    end

    def correct_plato
      @plato = Plato.find(params[:id])
      redirect_to root_path unless current_rover? @plato.rover
    end
end

