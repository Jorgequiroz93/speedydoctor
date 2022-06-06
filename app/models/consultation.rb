class Consultation < ApplicationRecord
  belongs_to :patient, class_name:'User', foreign_key: 'patient_id'
  belongs_to :doctor, class_name:'User', foreign_key: 'doctor_id'
  has_one :review
  has_one :report

  validates :patient_id,  uniqueness: true, presence: true
  validates :doctor_id,  uniqueness: true, presence: true

end
