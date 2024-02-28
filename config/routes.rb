Rails.application.routes.draw do
  #user routes
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  post "/users" => "users#create" #SIGNUP for user
  patch"/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  #authentication login in
  post "/sessions" => "sessions#create"

end
