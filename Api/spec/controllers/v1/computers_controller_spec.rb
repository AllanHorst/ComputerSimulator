require 'rails_helper'

RSpec.describe V1::ComputersController, type: :controller do

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
end
