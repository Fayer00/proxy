class DeteleTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :proxy_urls
    drop_table :api_requests

  end
end
