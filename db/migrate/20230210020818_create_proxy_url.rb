class CreateProxyUrl < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  def change
    create_table :proxy_urls do |t|
      t.string :url_id, null: false
      t.string :url_type, null: false
      t.timestamps
    end
    add_index :proxy_urls, [:url_id, :url_type], algorithm: :concurrently
  end
end
