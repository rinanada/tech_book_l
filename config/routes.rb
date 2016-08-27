Rails.application.routes.draw do
  root "exhibits#index"
  devise_for :users, :controllers => { :sessions => 'exhibits/sessions'
}
  resources :exhibits, only: [:show]
end
