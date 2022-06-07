class Consultation < ApplicationRecord
  # consultation.patient => User, participating in consulation as a PATIENT
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  # consultation.doctor => User, participating in consulation as a DOCTOR
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  has_one :review
  has_one :report

  STATUSES = ['calling', 'online', 'finished', "cancelled"]

  validates :patient_id, presence: true
  validates :doctor_id, presence: true
end
