Rails.application.routes.draw do
  get 'terms' => 'site#terms'

  get 'login' => 'session#new'
  post 'login' => 'session#create'

  get 'logout' => 'session#destroy'

  root 'site#index'
end
