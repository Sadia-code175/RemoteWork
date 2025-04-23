class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.decimal :salary
      t.text :skills_required
      t.references :hiring_client_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
