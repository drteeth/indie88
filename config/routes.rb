Indie88::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    get '/stats' => 'artists#stats'
    resources :artists
  end

  root :to => 'application#index'
end
