require 'rails_helper'

RSpec.describe V1::ComputersController, type: :controller do
  let(:computer) {
    Computer.create({stack: 10})
  }
  context '#new' do
    before(:each) {
      post :new, params: {stack: 100}
    }
    it 'returns new computer id' do
      expect(assigns(:computer)).to_not eq(nil)
    end

    describe 'response' do
      subject {JSON.parse(response.body)}

      it { is_expected.to include("id") }
    end

  end

  context '#set_address' do
    before(:each) {
      put :set_address, params: {  computer_id: computer.id, addr: 10}
    }

    it 'load computer' do
      expect(assigns(:computer)).to eq(computer)
    end

    it 'set computer poiter to 10' do
      computer.reload
      expect(computer.pointer).to eq(10)
    end
  end


  context '#insert_instruction' do

    context 'with args' do
      before(:each) {
        post :insert_instruction, params: { instruction: 'PUSH', computer_id: computer.id, arg: 10}
      }

      it 'load computer' do
        expect(assigns(:computer)).to eq(computer)
      end

      it 'set computer poiter to 10' do
        computer.reload
        expect(JSON.parse computer.stack[0]).to eq({"instruction" => 'PUSH', 'param' => '10'})
      end
    end

    context 'without args' do
      it 'set computer poiter to 10' do
        post :insert_instruction, params: { instruction: 'PRINT', computer_id: computer.id}
        computer.reload
        expect(JSON.parse computer.stack[0]).to eq({"instruction" => 'PRINT', 'param' => nil})
      end
    end
  end
end
