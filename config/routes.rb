Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  namespace :admin do
    get 'dashboard', :to => 'dashboards#index', :as => :dashboard
  end
end
