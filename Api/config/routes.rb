Rails.application.routes.draw do
  namespace :v1 do
    post 'you-app-server/v1/computers' => 'computers#new'
  end
end
