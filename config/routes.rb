Rails.application.routes.draw do
  resources :services
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :services, controller: 'services', only: [:index, :show,:edit, :update, :new, :destroy]

end
