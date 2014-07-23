Rails.application.routes.draw do
  
  get 'users/search'
  post 'users/search', to:'users#do_search', as: 'user_search'

  # namespace :donation_record do
  #   resources :actual_funds
  # end

  nested_actions = [:new, :create]
  origin_actions = [:show, :edit, :update, :destroy]


  get 'users/:id', to: 'users#show', as: :user

  resources :customer_groups

  resources :donation_types

  resources :univ_units

  resources :univ_unit_managers

  resources :usage_types

  resources :projects do
    resources :donation_records, only: nested_actions
    resources :usage_records, only: nested_actions
    resources :link_men
    member do
      get 'new_attachment'
      post 'attachments', to: 'projects#create_attachment', as: :attachments
      delete 'attachments/:attachment_id', to: 'projects#destroy_attachment', as: :attachment
    end
  end

  get 'link_men/search'
  post 'link_men/search', to: 'link_men#search', as: 'link_man_search'
  
  get 'customers/search', to: 'customers#search', as: 'customer_search'
  post 'customers/search', to: 'customers#do_search'

  resources :usage_records, only: origin_actions do
    member do
      get 'new_attachment'
      post 'attachments', to: 'usage_records#create_attachment', as: :attachments
      delete 'attachments/:attachment_id', to: 'usage_records#destroy_attachment', as: :attachment
    end
  end

  resources :donation_records, only: origin_actions do
    member do
      get 'new_attachment'
      post 'attachments', to: 'donation_records#create_attachment', as: :attachments
      delete 'attachments/:attachment_id', to: 'donation_records#destroy_attachment', as: :attachment
    end
  end


  ##Things below are workarounds for namespaced model to use a nested resource
  resources :actual_funds, controller: 'donation_record/actual_funds', only: [:edit]
  namespace :donation_record do
    resources :actual_funds, only: [:show, :update]
  end
  resources :donation_records do
    resources :actual_funds, controller: 'donation_record/actual_funds', only: nested_actions
  end
  ##

  resources :fund_types

  resources :funds

  resources :project_types

  resources :project_states

  resources :project_levels

  resources :projects

  resources :customers do
    resources :contact_records
  end

  resources :customer_groups do
    delete "customers/:id", to: 'customer_groups#delete_customer', as: :customer
    get "customers/:id", to: 'customer_groups#delete_customer'
  end
  resources :online_customers

  resources :corporate_customers

  resources :individual_customers

  resources :customers

  namespace :employee do
    get 'manage', to: 'manage#index'
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
