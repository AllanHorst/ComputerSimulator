class Computer
  include ActiveModel::Model
  attr_accessor :pointer, :stack_size, :instructions, :stack

  def initialize(stack_size)
    @stack_size = stack_size
    @pointer = 0
    @instructions = []
    @stack = []
  end

  def set_address(address)
    @pointer = address
  end

  def insert(command, value=nil)
    @instructions << ({
      command: command,
      param: value
    })
  end

  def execute
    while true do
      instruction = @instructions[@pointer]
      exit unless instruction
      if instruction[:param]
        send(instruction[:command].downcase, instruction[:param])
      else
        send(instruction[:command].downcase)
      end
      @pointer = @pointer.next
    end
  end

  private

  def push(value)
    @stack << value
  end

  def mult
    values = @stack.pop(2)
    @stack<<values.inject(:*)
  end

  def call(value)
    @pointer = value
  end

end