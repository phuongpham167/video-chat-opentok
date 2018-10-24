Rails.application.routes.draw do
  resources :rooms
  root "rooms#index"
  match '/party/:id', :to => "rooms#party", :as => :party, :via => :get
  resources :posts
end
