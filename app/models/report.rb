class Report < ApplicationRecord
  belongs_to :consultation
  has_one :patient, through: :consultations
  has_one :doctor, through: :consultations

  validates :consultation_id,  presence: true
  validates :content,  presence: true
end
