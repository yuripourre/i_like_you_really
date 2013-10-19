ILikeYouReally::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  #devise_scope :user do
    #get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    #get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end

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
