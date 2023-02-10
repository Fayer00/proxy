module Api
  module V1
    class ProxyController < ApplicationController

      #i think this with a loadbalancer like Nginx would work great
      def get_proxy_url
        puts "aaaaaaa #{request.url}"
        Rails.cache.fetch("#{params[:url_type]}/#{params[:url_id]}", expires_in: 10.minutes) do
          render json: ProxyUrl.meli_api_get(params[:url_type],params[:url_id] )

        end
        #@proxy_url = ProxyUrl.find_or_create_by(url_id: params[:id], url_type: params[:url_type])

        # if stale?(@proxy_url)
        # render json: @proxy_url.new_url
        # end
        puts "lalalal"
        #add cache and logic to generate the response https://api.mercadolibre.com + path
      end


    end
  end
end