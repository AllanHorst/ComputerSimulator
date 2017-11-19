class Computer
  include ActiveModel::Model
  attr_accessor :pointer, :instructions, :stack

  def initialize(stack_size)
    @stack_size = stack_size
    @pointer = 0
    @instructions = Array.new(stack_size)
    @stack = []
  end

  def set_address(address)
    @pointer = address
  end

  def insert(command, value=nil)
    @instructions[@pointer] = {
      command: command,
      param: value
    }
    increment_pointer
  end

  def execute
    while true do
      instruction = @instructions[@pointer]
      break unless instruction

      if instruction[:param]
        send(instruction[:command].downcase, instruction[:param])
      else
        send(instruction[:command].downcase)
      end

    end
  end

  private

  def push(value)
    @stack << value
    increment_pointer
  end

  def mult
    values = @stack.pop(2)
    @stack << values.inject(:*)
    increment_pointer
  end

  def print
    increment_pointer
  end

  def call(address)
    @pointer = address
  end

  def ret
    @stack.pop
  end

  def increment_pointer
    @pointer = @pointer.next
  end
end