class CreateConsultations < ActiveRecord::Migration[6.1]
  def change
    create_table :consultations do |t|
      t.string :symptoms
      t.string :status
      t.float :total_price
      t.datetime :start_time
      t.datetime :end_time
      t.references :doctor, null: false, foreign_key: {to_table: :users}
      t.references :patient, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
