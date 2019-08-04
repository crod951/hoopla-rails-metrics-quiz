Rails.application.routes.draw do

  root "dashboards#index"

  get "metrics/:metric_id", to: 'metrics#show'
  get "users/:user_id/metrics/:metric_id/values/:value_id", to: 'users#edit'
  get "users/:user_id/metrics/:metric_id", to: 'users#edit'
  put "users/:user_id/update", to: 'users#update'
  post "users/:user_id/create", to: 'users#create'
end
