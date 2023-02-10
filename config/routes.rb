Rails.application.routes.draw do
  get '/:url_type/:url_id', to: 'api/v1/proxy#get_proxy_url'

  namespace :api do
   namespace :v1 do
     get '/proxy/get_proxy_url/:url_type/:url_id' => 'api/v1/proxy#get_proxy_url', as: :proxy_url
    end
  end
end
