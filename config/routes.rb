ApartmenthomelivingSampleApp::Application.routes.draw do
  root :to => 'listings#index'

  resources :listings do
    collection do
      get :search
    end
    resources :floorplans
  end
end
