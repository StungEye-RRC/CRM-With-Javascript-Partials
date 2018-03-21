Rails.application.routes.draw do
  resources :customers, only: [:index, :show] do
    collection do
      get :missing_email
    end
  end

  root to: 'customers#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
