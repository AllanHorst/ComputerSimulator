class V1::ComputersController < ApplicationController
  before_action :set_computer, only: [:set_address, :insert_instruction, :execute]
  def new
    @computer = Computer.create({stack_size: params[:stack]})
    render json: @computer, only: [:id, :pointer]
  end

  def set_address
    @computer.set_address params[:addr]
    @computer.save
    render json: @computer, only: [:pointer]
  end

  def insert_instruction
    @computer.insert params[:instruction], params[:arg]
    @computer.save
    render json: @computer, only: [:stack, :pointer]
  end

  def execute
    render json: @computer.execute
  end

  private

  def set_computer
    @computer = Computer.find params[:computer_id]
  end

end
