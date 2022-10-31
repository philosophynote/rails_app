Rails.application.routes.draw do
  root "rule_managements#new"

  get "/rule_managements", to: "rule_managements#new"
end
