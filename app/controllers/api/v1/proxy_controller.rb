module Api
  module V1
    class ProxyController < ApplicationController

      #i think this with a loadbalancer like Nginx would work great
      def get_proxy_url
        Rails.cache.fetch("#{params[:url_type]}/#{params[:url_id]}", expires_in: 10.minutes) do
          render json: ProxyUrl.meli_api_get(params[:url_type],params[:url_id] )

        end
        #add cache and logic to generate the response https://api.mercadolibre.com + path
      end


    end
  end
end