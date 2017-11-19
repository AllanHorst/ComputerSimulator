class Computer < ApplicationRecord
  attr_accessor :data

  def initialize(params={})
    stack_size = params.delete(:stack_size)
    super
    self.pointer = 0
    self.stack = Array.new(stack_size)
  end

  def set_address(address)
    self.pointer = address
  end

  def insert(command, value=nil)
    self.stack[self.pointer] = {
      command: command,
      param: value
    }
    increment_pointer
  end

  def execute
    self.data = []
    while true do
      instruction = self.stack[self.pointer]
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
    self.data << value
    increment_pointer
  end

  def mult
    values = self.data.pop(2)
    self.data << values.inject(:*)
    increment_pointer
  end

  def print
    increment_pointer
    self.data.pop
  end

  def call(address)
    self.pointer = address
  end

  def stop
    self.pointer = -1
  end

  def ret
    # TODO
  end

  def increment_pointer
    self.pointer = self.pointer.next
  end
end