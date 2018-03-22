Rails.application.routes.draw do
  resources :customers, only: [:index, :show] do
    collection do
      get :missing_email # GET /customers/missing_email
      post :clear_call_list
    end

    member do
      post :add_to_call_list # POST /customers/:id/add_to_call_list
      post :mark_as_called   # POST /customers/:id/mark_as_called
    end
  end

  root to: 'customers#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
