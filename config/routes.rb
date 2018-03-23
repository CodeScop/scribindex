Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
	root 'projects#index'
  resources :scenes do
  	resources :notes
  end
  resources :groups do
  	resources :notes
  end
  resources :characters do
  	resources :notes
  end
  resources :projects do
  	resources :notes
  end
  devise_for :users

  post 'charmem' => 'characters#membership'
  post 'groupmem' => 'groups#membership'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
