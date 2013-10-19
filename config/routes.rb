ILikeYouReally::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    resources :comments
    resources :activities
  end

  root to: "main#index"

  resources :facebook do
    collection do
      get :friends
      post :add_friends
    end
  end

  resources :facebook_guest do
    collection do
      get :friends
      post :add_friends
    end
  end
  
end
