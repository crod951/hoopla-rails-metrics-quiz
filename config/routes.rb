Rails.application.routes.draw do

  root "dashboards#index"

  get "metrics/:metric_id", to: 'metrics#show'

end
