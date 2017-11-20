Rails.application.routes.draw do
  namespace :v1 do
    post '/computers' => 'computers#new'
    post '/computers/:computer_id/exec' => 'computers#execute'

    scope 'computers/:computer_id/stack' do
      match '/pointer' => 'computers#set_address', via: [:put, :patch]
      post '/insert/:instruction' =>  'computers#insert_instruction'
    end

  end
end
