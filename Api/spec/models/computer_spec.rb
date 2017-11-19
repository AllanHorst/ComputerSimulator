require 'rails_helper'

RSpec.describe V1::ComputersController, type: :service do

  let(:computer) {
    Computer.new(20)
  }

  context '#new' do
    it 'pointer must be 0' do
      expect(computer.pointer).to eq(0)
    end

    it 'stack size must be 20' do
      expect(computer.stack_size).to eq(20)
    end

    it 'instructions cannot be nil' do
      expect(computer.instructions).to_not eq(nil)
    end
  end

  context '#set_address' do
    let(:new_address) {
      10
    }
    let(:start_address) {
      0
    }

    it 'set pointer' do
      computer.set_address(new_address)
      expect(computer.pointer).to eq(new_address)
    end

    it 'change pointer' do
      computer.set_address(start_address)
      expect(computer.pointer).to eq(start_address)
    end

  end

  context '#insert' do

    it 'insert new command into instructions' do
      computer.insert('push', 10)
      expect(computer.instructions.size).to eq(1)
    end

  end
end
