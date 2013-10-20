require 'sidekiq/web'

ILikeYouReally::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    resources :comments
    resources :activities
  end
  root to: "main#index"

  resources :facebook do
    collection do
      get :friends, path: "/choose/friends"
      post :add_friends
      put :toggle_like
      put :toggle_comment
    end
  end
  resources :facebook_guest do
    collection do
      get :friends
    end
  end

  resources :dashboards

  put "/wizard/:wizard_name/hide" => "wizards#hide", as: "hide_wizard"
end
