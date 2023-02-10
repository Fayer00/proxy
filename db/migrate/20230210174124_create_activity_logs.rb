class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.text :path
      t.text :ip
      t.text :action

      t.timestamps
    end
  end
end
