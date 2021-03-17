Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "pages#index"
  get 'pages/mypage', to: "pages#mypage"
  resources :articles
  resources :pages
  get 'signup', to: "users#new"
  resources :users, except: [:new]
end
