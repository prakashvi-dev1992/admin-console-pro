Rails.application.routes.draw do

  devise_for :admins, :controllers => { 
      :sessions => "admins/sessions", 
      :registrations => "admins/registrations", 
      :passwords => "admins/passwords", 
      :confirmations => "admins/confirmations"
    }

  devise_for :users, :controllers => { 
      :sessions => "users/sessions", 
      :registrations => "users/registrations", 
      :passwords => "users/passwords", 
      :confirmations => "users/confirmations"
    }
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  devise_scope :user do
    #root to: 'users/sessions#new'
    authenticated :user do
      root 'users#home', as: :user_home
    end

    unauthenticated do
      root 'users#dashboard', as: :unauthenticated_root
    end

    get 'users/sign_in', to: 'users/sessions#new' , :path => "user/login"
    delete 'users/sign_out', to: 'users/sessions#destroy' , :path => "user/logout" 
  end
  
  

  devise_scope :admin do
    authenticated :admin do
      root 'admins/dashboard#home'
    end

    unauthenticated do
      root 'admins/sessions#new', as: :unauthenticated_admin_root
    end

    get 'admins/sign_in', to: 'admins/sessions#new' , :path => "admin"
    get 'admins/sign_up', to: 'admins/registrations#new' , :path => "admin/sign_up"
    delete 'admins/sign_out', to: 'admins/sessions#destroy' , :path => "admin/logout"
  end

  namespace :admins do
    resources :users
    resources :static_pages
    resources :inquiries
    get 'home' => 'dashboard#home'
    get 'home/:id' => 'users#show'
   end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  resource :admin, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  get 'users/:id' => 'users#show'

  get '/home' => 'users#home'

  get '/dashboard' => 'users#dashboard'

  get 'contact-us' => 'inquiries#new',as: 'contact_us'

  get '/:route' => 'users#page'

  resources :inquiries , :only=>[:new,:create]

  match '*unmatched_route', :to => 'application#raise_not_found' ,:via => [:all]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  # get '/static_pages/all', to: 'static_pages#index', as: 'all_static_page'
end
