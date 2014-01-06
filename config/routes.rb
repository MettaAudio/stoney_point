StoneyPoint::Application.routes.draw do
  devise_for :users
  resources :organizations

  resources :work_days

  resources :housings

  resources :caddies

  resources :golfers

  resources :jobs

  resources :committees

  resources :volunteers

  post "/add_volunteer_committee", to: "volunteers#add_committee", as: 'add_volunteer_committee'
  post "/add_volunteer_job", to: "volunteers#add_job", as: 'add_volunteer_job'
  post "/add_volunteer_organization", to: "volunteers#add_organization", as: 'add_volunteer_organization'
  post "/add_volunteer_housing", to: "volunteers#add_housing", as: 'add_volunteer_housing'
  post "/add_golfer_to_housing", to: "housings#add_golfer", as: 'add_golfer_to_housing'

  get "/shirts", to: "volunteers#shirts", as: 'shirts'

  root :to => 'volunteers#index'

end
