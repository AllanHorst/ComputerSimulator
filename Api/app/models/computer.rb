class Computer < ApplicationRecord
  attr_accessor :data, :output

  def initialize(params={})
    stack_size = params.delete(:stack_size)
    super
    self.pointer = 0
    self.stack = Array.new(stack_size.to_i)
  end

  def set_address(address)
    self.pointer = address
  end

  def insert(instruction, value=nil)
    self.stack[self.pointer] = {
      instruction: instruction,
      param: value
    }.to_json
    increment_pointer
  end

  def execute
    self.data = []
    self.output = []
    while true do
      item = stack_item
      break unless item

      if item["param"]
        send(item["instruction"].downcase, item["param"].to_i)
      else
        send(item["instruction"].downcase)
      end

    end
    self.output
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
    self.output << self.data.pop
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

  def stack_item
    JSON.parse self.stack[self.pointer] if self.stack[self.pointer]
  end
end