class Api::V1::ProxyController < ApplicationController
  def show
    id = params[:id]
    render json: { id: id }
  end


  def url
    path = request.path
    #add cache and logic to generate the response https://api.mercadolibre.com + path
  end
end