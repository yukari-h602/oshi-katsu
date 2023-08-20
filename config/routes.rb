Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  root 'static_pages#top'

	get 'terms_of_service', to: 'static_pages#terms_of_service'
	get 'privacy_policy', to: 'static_pages#privacy_policy'

	get 'login', to: 'user_sessions#new'
	post 'login', to: 'user_sessions#create'
	delete 'logout', to: 'user_sessions#destroy'
	
	resources :users, only: %i[new create show] do
		resource :relationships, only: [:create, :destroy]
		get 'followings' => 'relationships#followings', as: 'followings'
		get 'followers' => 'relationships#followers', as: 'followers'
	end

	resources :boards do
		resources :comments, only: %i[create], shallow: true
		collection do
			get :bookmarks
		end
	end
	resources :bookmarks, only: %i[create destroy]

	resource :profile, only: %i[show edit update]
end
