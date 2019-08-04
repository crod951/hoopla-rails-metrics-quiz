Rails.application.routes.draw do

  root "dashboards#index"

  get "metrics/:metric_id", to: 'metrics#show'
  get "users/:user_id/:metric_id/:value_id", to: 'users#edit'
  put "users/:user_id/update", to: 'users#update'
end
