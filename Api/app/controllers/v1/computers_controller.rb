class V1::ComputersController < ApplicationController

  def new
    @computer = Computer.new(params[:stack].to_i)
    render
  end

end
