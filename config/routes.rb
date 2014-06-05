#====patch====
module ActionDispatch
  module Routing
    class Mapper
      module Resources
        def gen_get(path, controller, action)
          get path => "#{controller}\##{action}", :as => "#{controller.to_s.singularize}_#{action}"
        end        
      end
    end
  end
end
#========
Trochilus::Application.routes.draw do

  get 'link_men/show'

  get 'link_men/new'

  get 'link_men/edit'

  # get 'actual_funds/show'

  # get 'actual_funds/new'

  # get 'actual_funds/create'

  # get 'actual_funds/update'

  # get 'actual_funds/destroy'

  root :to => 'session#index'

  resources :donation_records do
    resources :actual_funds
  end
  resources :actual_funds


  resources :customer_projects


  resources :donation_types


  resources :funds


  resources :fund_types



  resources :project_types


  resources :users




  #==Employee==
  scope 'employee/manage/' do
    gen_get 'projects', :employees, 'manage_project'
    gen_get '', :employees, 'manage'
    gen_get 'customers', :employees, 'manage_customer'
    gen_get 'fund', :employees, 'manage_fund'

    gen_get 'add_customer', :employees, 'add_customer'
    gen_get 'customers', :employees, 'manage_customer'

    get 'add_customer/individual' => 'individual_customers#new', as: 'employee_add_individual_customer'

  end

  resources :projects do
    resources :link_men
  end
  
  post 'link_men/search' => 'link_men#search', as: 'link_man_search'
  #============
  get 'session/index'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout', as: 'logout'

  get 'admin' => 'admin#index', :as => 'admin'

  post 'admin/do_migrate', :as => 'migrate'
  post 'admin/rails_r', :as => 'rails_r'


  resources :individual_customers

  resources :contact_records

  resources :employees

  resources :online_customers

  resources :corporate_customers

  resources :orgnization_customers


  resources :customer_types

  resources :customers


  resources :project_states

  resources :project_levels

  resources :projects

  get 'cms/index'
  get 'cms/admin'

  get 'cms' => 'cms#index', as: 'cms'
  
  resources :channels

  resources :articles

  
  # get "main/index"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
