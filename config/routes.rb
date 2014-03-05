StoneyPoint::Application.routes.draw do
  devise_for :users
  resources :organizations

  resources :work_days

  resources :housings

  resources :caddies

  resources :golfers

  resources :jobs

  resources :shifts

  resources :committees

  resources :volunteers

  post "/add_volunteer_committee", to: "volunteers#add_committee", as: 'add_volunteer_committee'
  post "/add_volunteer_job", to: "volunteers#add_job", as: 'add_volunteer_job'
  post "/add_volunteer_shift", to: "volunteers#add_shift", as: 'add_volunteer_shift'
  post "/duplicate_volunteer", to: "volunteers#duplicate", as: 'duplicate_volunteer'
  post "/add_golfer_caddie", to: "golfers#add_caddie", as: 'add_golfer_caddie'
  post "/add_volunteer_organization", to: "volunteers#add_organization", as: 'add_volunteer_organization'
  post "/add_caddie_organization", to: "caddies#add_organization", as: 'add_caddie_organization'
  post "/add_volunteer_housing", to: "volunteers#add_housing", as: 'add_volunteer_housing'
  post "/add_golfer_to_housing", to: "housings#add_golfer", as: 'add_golfer_to_housing'

  get "/shirts", to: "volunteers#shirts", as: 'shirts'
  get "/address_list", to: "volunteers#address_list", as: 'volunteers_address_list'

  root :to => 'volunteers#index'

end
