Indie88::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    get '/stats' => 'artists#stats'
    resources :artists do
      collection do
        get 'random'
      end
    end
  end

  root :to => 'application#index'
end
