class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :freelancer_profile, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
