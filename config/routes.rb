Rails.application.routes.draw do
  root 'pages#home'

  get "about" => "pages#about"

  get "help" => "pages#help"

  get "contact" => "pages#contact"

  get "policies" => "pages#policies"

  get "sponsor" => "pages#sponsor"

  get "suggest" => "pages#suggest"

  get "individual_contest" => "posts#individual_contest"

  get "currentcontests" => "posts#all_current_contests"

  get "awaitingcontests" => "posts#awaiting_contests"

  get "newcontest" => "posts#new_contest"


  resources :contests do
    get 'previous', on: :collection
    resources :photos, only: [:create, :show]
  end


  devise_for :admins

  namespace :admin do
    root to: 'contests#index'

    resources :contests, only: [:show, :index, :edit, :update, :destroy] do
      resources :photos, only: [:destroy] do
      end

      member do
        put 'approve', as: :approve
      end

      collection do
        get 'all', as: :all
      end        
    end

    resources :admins
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
