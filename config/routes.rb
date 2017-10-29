Rails.application.routes.draw do
    resources :databases
  
    get '/read_message/:id' => 'read_message#read' 
    get 'create_message' => 'create_message#index'
    post 'create_message' => 'create_message#create'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
