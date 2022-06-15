class Review < ApplicationRecord
  belongs_to :consultation
  has_one :doctor, through: :consultations
  has_one :patient, through: :consultations

  validates :consultation_id, presence: true

  def blank_stars
    5 - rating.to_i
  end
end
