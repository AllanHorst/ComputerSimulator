require 'rails_helper'

RSpec.describe V1::ComputersController, type: :controller do

  context '#new' do

    it 'returns new computer id' do
      post :new, params: {stack: 100}
      p JSON.response(response.body)
      # expect(JSON.response(response.body)).to eq()
    end

  end
end
