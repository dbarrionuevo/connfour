Rails.application.routes.draw do
  get '/games/:user_id', to: 'games#show', as: 'game'

  resources :users do
    resources :games do
    end
  end

  delete '/restart', to: 'games#restart', as: 'restart'
end
