class AddPersonalNotesToConsultation < ActiveRecord::Migration[6.1]
  def change
    add_column :consultations, :doctor_notes, :string
    add_column :consultations, :patient_notes, :string
  end
end
