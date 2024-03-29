Rails.application.routes.draw do
  
  namespace :serve do
    resources :campaigns
    get 'settings/index'
  end

  namespace :ops do
    resources :ads do
      member do
        put :approve
      end
    end
    resources :creatives do
      member do
        put :approve
      end
    end
  end

  get 'reddit_proxy/subreddits'

  namespace :admin do
    resources :orgs do
      resources :memberships
    end
  end

  namespace :account do
    resources :users
  end

  namespace :superuser do
    resources :users
  end

  resources :orgs do
    resources :ads
    resources :creatives
    resources :campaigns do
      member do
        get :performance
      end
      resources :ads_campaigns
    end
    resources :assets
  end
  resources :users

  # OmniAuth for all providers, see `config/initializers/omniauth.rb` for more
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'sessions/new'
  get 'sessions/destroy'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
end
