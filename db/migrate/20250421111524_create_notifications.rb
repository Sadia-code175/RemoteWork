class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true, null: false
      t.references :sender, polymorphic: true, null: false
      t.text :message
      t.string :notification_type
      t.boolean :read

      t.timestamps
    end
  end
end
