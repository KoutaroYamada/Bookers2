Rails.application.routes.draw do

  root "root#top"
  get "/home/about" => "root#about"
  devise_for :users
  resources :books, only:[:index, :show, :create, :edit, :update, :destroy]
  resources :users, only:[:index, :show, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
