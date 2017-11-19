require 'rails_helper'

RSpec.describe Computer, type: :model do

  let(:computer) {
    Computer.new(20)
  }

  let(:new_address) {
    10
  }
  let(:start_address) {
    0
  }

  context '#new' do
    it 'pointer must be 0' do
      expect(computer.pointer).to eq(0)
    end

    it 'instructions cannot be nil' do
      expect(computer.instructions.count).to eq(20)
    end
  end

  context '#set_address' do

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
      computer.insert('PUSH', 10)
      expect(computer.instructions[start_address]).to eq({
        command: 'PUSH',
        param: 10
      })
    end

    it 'insert into position' do
      computer.set_address(new_address)
      computer.insert('PUSH', 10)
      expect(computer.instructions[new_address]).to eq({
        command: 'PUSH',
        param: 10
      })
    end

  end

  context '#execute' do

    context 'stack' do

      it 'stack should be equal' do
        computer.insert('PUSH', 10)
        computer.insert('PUSH', 50)
        computer.insert('MULT')
        computer.insert('PRINT')
        computer.insert('CALL', new_address)
        computer.set_address(new_address)
        computer.insert('PUSH', 2)
        computer.insert('PUSH', 2)
        computer.insert('MULT')
        computer.insert('PRINT')
        puts 'EXECUTE'
        computer.set_address(start_address)
        computer.execute

        expect(computer.stack).to eq([500, 4])
      end
    end

  # context 'MULT' do
  #   before(:each) do
  #     computer.insert('PUSH', 10)
  #     computer.insert('PUSH', 50)
  #     computer.insert('MULT')
  #     computer.execute
  #   end

  #   it 'last value must be the multiplication' do
  #     expect(computer.stack.last).to eq(500)
  #   end

  #   it 'should pop last values' do
  #     expect(computer.stack.count).to eq(1)
  #     expect(computer.stack).to_not include(10)
  #     expect(computer.stack).to_not include(50)
  #   end
  # end

  # context 'RET' do
  #   before(:each) do
  #     computer.insert('PUSH', 10)
  #     computer.insert('PUSH', 50)
  #     computer.insert('RET')
  #     computer.execute
  #   end

  #   it 'last value must be the multiplication' do
  #     expect(computer.stack.last).to eq(10)
  #   end

  #   it 'should pop last values' do
  #     expect(computer.stack.count).to eq(1)
  #     expect(computer.stack).to_not include(50)
  #   end
  # end
  end

end
