Rails.application.routes.draw do
  get '/:url_type/:url_id', to: 'api/v1/proxy#get_proxy_url'
end
