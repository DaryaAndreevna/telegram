Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users
  resources :webhooks, only: [] do 
    collection do 
      post :telegram_lXQnaR2oyMmE01thbCsMzyVI9KWYZNxgbHKFWmXZyDiQnwnj12msitOc8yUfuaZK
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
