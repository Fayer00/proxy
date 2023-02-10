Rails.application.routes.draw do
  resources :activity_logs
  get '/:url_type/:url_id', to: 'api/v1/proxy#get_proxy_url'
end
