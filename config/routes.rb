SampleApplication::Application.routes.draw do

  #get "preferences/edit"

  #get "preferences/show"

  get "chats/index"
  get "chats/send_data"

  get "networks/index"
  get "networks/edit"

  get "emails/remind"
  get "emails/correspond"

  get "friendships/initiate"
  get "friendships/accept"
  get "friendships/decline"
  get "friendships/cancel"
  get "friendships/delete"

  get "faqs/index"
  get "faqs/edit"

  #get "specs/new"
  #get "specs/index"

  #get "specs/edit"

  #get "profiles/index"

  #get "profiles/show"
  resources :emails do
    member do
      get "correspond" #enable using rout helper 'correspond_email_path' 
    end
  end

  resources :faqs
  resources :specs

  resources :users do
    member do
      get :friends
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  resources :profiles
  resources :friendships
  resources :networks
  resources :chats
  resources :preferences
  resources :posts

  match "/signup", :to=> "users#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy"
  match "/home", :to=>"pages#home"
  match "/help", :to =>"pages#help"
  match "/contact", :to =>"pages#contact"
  match "/about", :to =>"pages#about"
  match "/request", :to =>"friendships#create"
  match "/emails/remind", :to =>"emails#remind"
  match "/emails/correspond", :to => "emails#correspond"
  match "/friendships/initiate", :to => "friendships#initiate"
  match "/friendships/accept", :to => "friendships#accept"
  match "/friendships/delete", :to => "friendships#delete"
  #match "emails/correspond/:id", :as => "correspond"
  match "/chats/send_data", :to => "chats#send_data"
  match "/preferences/edit", :to => "preferences#edit"
  match "/preferences/show", :to => "preferences#show"

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
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
