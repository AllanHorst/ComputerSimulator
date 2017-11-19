class Computer
  include ActiveModel::Model
  attr_accessor :pointer, :stack_size, :instructions

  def initialize(stack_size)
    @stack_size = stack_size
    @pointer = 0
    @instructions = []
  end

  def set_address(address)
    @pointer = address
  end

  def insert(command, value=nil)
    @instructions << ({
      command: command,
      value: value
    })
  end

end