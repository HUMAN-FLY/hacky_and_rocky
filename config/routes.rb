Enpit::Application.routes.draw do

  get "race_progresses/show"
  resources :books

  #resources :race_horses
  root 'races#top'

  # Race
  get '/races(.:format)'        => "races#index", :as => :races
  get '/race/:id(.:format)'     => "races#show",  :as => :race

  # Race progress
  #get '/race/:id/progresses/:date/race_horses' => "race_progresses#race_horses"
  get '/race/:id/progresses/:date' => "race_progresses#show", :as => :race_progress

  # Race result
  get '/race/:id/result'        => "race_results#show", :as => :race_result

  # Voting card
  post '/race/:id/voting_cards' => 'voting_cards#vote', :as => :voting_cards

  # Comment
  post '/race/:race_id/comments' => 'comments#create',   :as => :comments

  # Administrator pages
  get    '/admin'               => "admin#home",        :as => :admin_home
  get    '/admin/login'         => "admin#login"
  get    '/admin/race/list'     => "admin#list_race",   :as => :adm_race
  get    '/admin/race/new'      => "admin#new_race",    :as => :new_race
  post   '/admin/race'          => "admin#create_race"
  get    '/admin/race/edit/:id' => "admin#edit_race",   :as => :edit_race
  put    '/admin/race/:id'      => "admin#update_race"
  patch  '/admin/race/:id'      => "admin#update_race"
  delete '/admin/race/:id'      => "admin#destroy_race"

  # testです・・・
  get 'races_test/test' => 'races#test'

  # Authentication
  get '/auth/:provider' => "sessions#create_developer" unless Rails.env.production? and !ENV['TEST']
  get '/auth/:provider/callback' => "sessions#create"
  get '/logout' => "sessions#destroy", :as => :logout

  # 以下は不要ルート。ちゃんとキレイにする
  get 'rankings/fetch' => "rankings#fetch"

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
