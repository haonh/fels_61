class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.timestamp :time
      t.string :content
      t.references :user

      t.timestamps null: false
    end
  end
end
