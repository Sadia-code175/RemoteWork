class CreateHiringClientProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :hiring_client_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :company_name
      t.text :company_details
      t.string :website

      t.timestamps
    end
  end
end
