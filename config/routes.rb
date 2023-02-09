Rails.application.routes.draw do
  get '/api/proxy' => 'api#proxy'
  #root to: redirect('/process_url/process')
  get '/:url_type/:id', to: 'api/v1/proxy#url'

  namespace :api do
    namespace :v1 do
      get "/tasks/:id", to: "tasks#show"
    end
  end
end
