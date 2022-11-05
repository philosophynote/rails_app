Rails.application.routes.draw do
  root "rules#new"

  resources :rules
  # get "/rule_managements", to: "rule_managements#new"
end
