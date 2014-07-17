Rails.application.routes.draw do
  get 'link_men/show'

  get 'link_men/new'

  get 'link_men/create'

  get 'link_men/edit'

  get 'link_men/destroy'

  get 'link_men/search'

  nested_actions = [:show, :new, :create]
  origin_actions = [:edit, :update, :destroy]

  resources :donation_types

  resources :univ_units

  resources :univ_unit_managers

  resources :usage_types

  resources :projects do
    resources :donation_records, only: nested_actions
    resources :usage_records, only: nested_actions
    resources :link_men
  end
  post 'link_men/search' => 'link_men#search', as: 'link_man_search'
  
  resources :usage_records, only: origin_actions
  resources :donation_records, only: origin_actions

  resources :donation_records do
    resources :actual_funds, only: nested_actions
  end
  resources :actual_funds, only: origin_actions

  resources :fund_types

  resources :funds

  resources :project_types

  resources :project_states

  resources :project_levels

  resources :projects

  resources :customers do
    resources :contact_records
  end

  resources :online_customers

  resources :corporate_customers

  resources :individual_customers

  resources :customers

  namespace :employee do
    get 'manage' => 'manage#index'
    get 'manage/projects'
    get 'manage/customers'
    get 'manage/funds'
  end

  resources :employees

  devise_for :users, controllers: { sessions: "users/sessions" }

  devise_scope :user do
    get "sign_in", to: "devise/sessions#new", as: :login
    delete "sign_out", to: "devise/sessions#destroy", as: :logout
  end

  root to: 'main#index'
  
  get 'main/index'


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
