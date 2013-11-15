ApartmenthomelivingSampleApp::Application.routes.draw do
  root :to => 'listings#index'

  resources :listings do
    resources :floorplans
  end
end
