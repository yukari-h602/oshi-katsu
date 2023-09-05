Rails.application.routes.draw do
  root 'static_pages#top'

	get 'terms_of_service', to: 'static_pages#terms_of_service'
	get 'privacy_policy', to: 'static_pages#privacy_policy'

	get 'login', to: 'user_sessions#new'
	post 'login', to: 'user_sessions#create'
	delete 'logout', to: 'user_sessions#destroy'
	
	resources :users, only: %i[new create show] do
		member do
			get :followings, :followers
		end
		resource :relationships, only: [:create, :destroy]
	end

	resources :boards do
		resources :comments, only: %i[create], shallow: true
		collection do
			get :bookmarks
		end
	end
	resources :bookmarks, only: %i[create destroy]

	resources :posts

	resource :profile, only: %i[show edit update]
end
