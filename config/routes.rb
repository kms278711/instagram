Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'posts#index'
  resources :posts do
    post 'like', to: 'posts#like', as: :like, on: :member
    # posts/:post_id/like vs. posts/:id/like
    # like_post_path
  end
  
  resources :users, only: [:show] do 
    post 'follow', to: 'users#follow', as: :follow, on: :member
  end
  
  # resources :posts do
  #   resources :comments
  # end
  
  # comments#show
  # posts/:post_id/comments/:id
  
  get 'mypage', to: 'posts#mypage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
