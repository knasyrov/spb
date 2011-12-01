Spb::Application.routes.draw do
  resources :articles
  resources :comments

  devise_for :users, :path => '/', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register"}
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
  end
  #devise_for :writers, :path => '/', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register"}, :controllers => { :sessions => "devise/sessions" }#, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register"}
  #devise_for :readers, :path => '/', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register"}, :controllers => { :sessions => "devise/sessions" }

  root :to => 'articles#index'
end
