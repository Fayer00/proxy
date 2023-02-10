class ProxyUrl < ActiveRecord::Base

  def self.meli_api_get(url_type,url_id)
    url = new_url(url_type, url_id)
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end

  private

  def self.new_url(url_type, url_id)
    "https://api.mercadolibre.com/#{url_type}/#{url_id}"
  end
end