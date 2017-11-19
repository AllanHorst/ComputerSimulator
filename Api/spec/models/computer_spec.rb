require 'rails_helper'

RSpec.describe Computer, type: :model do

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

  context '#execute' do

    describe 'stack' do
      before(:each) do
        computer.insert('PUSH', 10)
        computer.insert('PUSH', 50)
        computer.insert('MULT')
        computer.insert('PRINT')
        computer.insert('CALL', 20)
        computer.insert('PUSH', 2)
        computer.insert('PUSH', 2)
        computer.insert('MULT')
        computer.insert('PRINT')
        computer.execute
      end

      it 'stack should be equal' do
        expect(computer.stack).to eq([10, 50, 500, 2, 2, 4])
      end
    end

    context 'MULT' do
      before(:each) do
        computer.insert('PUSH', 10)
        computer.insert('PUSH', 50)
        computer.insert('MULT')
        computer.execute
      end
      it 'last value must be the multiplication' do
        expect(computer.stack.last).to eq(500)
      end

      it 'should pop last values' do
        expect(computer.stack.count).to eq(1)
        expect(computer.stack).to_not include(10)
        expect(computer.stack).to_not include(50)
      end
    end

  end
end
