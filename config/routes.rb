Rails.application.routes.draw do
  root 'welcome#index'
  get '/user', to:'user#index'
  get '/inicio', to:'welcome#index'

  resources :coins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
