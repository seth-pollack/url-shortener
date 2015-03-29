Rails.application.routes.draw do
  root 'links#index'
  post '/' => 'links#create'
  get '/:slug' => 'links#show'
end
