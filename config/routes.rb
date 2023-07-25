Rails.application.routes.draw do
  root 'static_pages#top'

	get 'terms_of_service', to: 'static_pages#terms_of_service'
	get 'privacy_policy', to: 'static_pages#privacy_policy'

	get 'login', to: 'user_sessions#new'
	post 'login', to: 'user_sessions#create'
	delete 'logout', to: 'user_sessions#destroy'
	
	resources :users, only: %i[new create]
	resources :boards, only: %i[index new create]
end
