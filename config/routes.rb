Rails.application.routes.draw do

  get '/logout', to: 'logins#logout'
  resources :logins do
    resources :mail_lists
  end

  match "*a", :to => "logins#new", via: :all
  root :to => "logins#new"
end
