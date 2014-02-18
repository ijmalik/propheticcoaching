Propheticcoaching::Application.routes.draw do


  get "dashboard/index"
   #get "dashboad/index"
   #get "dashboard" => "dashboard#index"
   #get '/dashboard', to: 'dashboard#index'
   #match '/dashboard', to: 'dashboard#index', via: :get
   #root :to => 'dashboard#index'
   #resource :dashboard , :only => [:index]
  #devise_for :users
  #devise_for :users, controllers: {registrations: "users/registrations"}
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  ActiveAdmin.routes(self)

  #resources :chats do
  #  collection do
  #    get :talk
  #  end
  #end
  resources :ebooks do
    collection do
      get 'search'
    end
    member do
      get 'pdf'
    end
  end

  resources :mentees do
    resources :events do
      collection do
        get :get_events
      end
    end
    resources :google_events #, :only => [:new, :create, :edit, :update]
  end

  resources :users, :only => [:index, :show] do
    resources :mentees do
      resources :goals
      resources :comments
    end
    resources :events do
      collection do
        get :get_events
      end
    end
    resources :google_events #, :only => [:new, :create]
  end

  resources :events, :only => [:index, :edit, :update, :destroy] do
    collection do
      get :get_events
    end
    member do
      post :move
      post :resize
    end
  end

  root :to => 'users#index'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the  root of your site routed with "root"
  #root 'coaches#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :documents

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
end
