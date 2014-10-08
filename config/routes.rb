Rails.application.routes.draw do


  namespace :region do
    get 'country', as: :country
    get 'state', as: :state
    get 'city', as: :city
  end

  namespace :schoolfellow do
    resources :teach_experiences
  end

  resources :teacher_titles

  resources :majors

  resources :degrees

  get 'users/search'
  post 'users/search', to:'users#do_search', as: 'user_search'

  # namespace :donation_record do
  #   resources :actual_funds
  # end

  nested_actions = [:new, :create]
  origin_actions = [:show, :edit, :update, :destroy]

  resources :customer_groups

  resources :donation_types

  resources :univ_units

  resources :univ_unit_managers

  resources :usage_types


  resources :projects do
    resources :donation_records, only: nested_actions
    resources :usage_records, only: nested_actions
    scope module: :project do
      resources :link_men
      resources :news, only: nested_actions
    end
    member do
      get 'new_attachment'
      post 'attachments', to: 'projects#create_attachment', as: :attachments
      delete 'attachments/:attachment_id', to: 'projects#destroy_attachment', as: :attachment
    end
  end

  namespace :project do
    resources :news, only: origin_actions
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
  scope shallow_prefix: :donation_record do
    resources :donation_record do
      resources :actual_funds, controller: 'donation_record/actual_funds', shallow: true
      resources :interest_periods, controller: 'donation_record/interest_periods', shallow: true
    end
  end

  namespace :usage_record do
    resources :funds, only: [:show, :update, :edit]
  end
  resources :usage_records do
    resources :funds, controller: 'usage_record/funds', only: nested_actions
  end
  resources :individual_customers do
    resources :study_experiences, controller: 'schoolfellow/study_experiences'
    resources :teach_experiences, controller: 'schoolfellow/teach_experiences'
  end
  ##

  resources :fund_types

  resources :funds

  resources :project_types

  resources :project_states

  resources :project_levels

  resources :projects

  resources :customers do
    get 'edit_type', as: :edit_type
    post 'type_change', as: :type_change
    resources :contact_records
  end

  resources :customer_groups do
    delete "customers/:id", to: 'customer_groups#delete_customer', as: :customer
    get "customers/:id", to: 'customer_groups#delete_customer'
  end
  resources :online_customers

  resources :corporate_customers do
    resources :link_men, controller: 'corporate_customers/link_men'
  end

  resources :individual_customers do
    resources :univ_experiences, controller: :schoolfellows
    # resources :schoolfellows
    # post 'univ_experiences', to: 'schoolfellows#create', as: :univ_experiences
    # get 'univ_experiences/:id/edit', to: 'schoolfellows#create', as: :univ_experiences_edit
    # put 'univ_experiences/:id', to: 'schoolfellows#update'
    # delete 'univ_experiences/:id', to: 'schoolfellows#destroy'
  end

  resources :customers

  namespace :employee do
    get 'manage', to: 'manage#index'
    namespace :manage do
      get 'projects'
      get 'customers'
      get 'funds', as: :funds
      namespace :fund do
        get 'manage_unit', to: '', as: :manage_unit
      end
      get 'others'
    end
  end

  resources :employees

  devise_for :users, skip: [:registrations], controllers: { sessions: "users/sessions" } , path_names: { sign_in: 'login', sign_out: 'logout' }

  devise_scope :user do
    get "login", to: "users/sessions#new", as: :login
    delete "logout", to: "users/sessions#destroy", as: :logout
  end
  
  resources :users, only: [:show], :constraints => { :id => /[0-9]+(\%7C[0-9]+)*/ } #don't set this before devise, which will be confused between /:id <=> /sign_up

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
