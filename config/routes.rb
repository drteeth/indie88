Indie88::Application.routes.draw do
  resources :songs
  resources :artists do
    resources :songs, only: [:new]
  end
end
