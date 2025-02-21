Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "finders#index"

  post "lookup", to: "finders#lookup", as: :lookup
  get "summarize", to: "finders#summarize", as: :summarize

  get "/register/", to: "registers#new", as: :new_profile
  post "/register/create", to: "registers#create", as: :create_profile

  get "/register/:id/edit", to: "registers#edit", as: :edit_profile
  patch "/register/:id/update", to: "registers#update", as: :update_profile

  get "/register/:id/success", to: "registers#show", as: :show_profile
end
