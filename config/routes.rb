Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  root to: "pages#home"

  resources :bank_accounts do
    get 'transfer_money'
  end
  #   post 'deposit_money'
  # end
   resources :account_transactions
  # post "deposit_money", to: "bank_accounts#deposit_money"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
