class CreateFreelancerProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :freelancer_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :skills
      t.text :projects
      t.text :cv_data
      t.decimal :hourly_rate

      t.timestamps
    end
  end
end
