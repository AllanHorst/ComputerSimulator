class V1::ComputersController < ApplicationController

  def new
    @computer = Computer.create({stack_size: params[:stack]})
    render json: @computer, only: [:id]
  end

end
