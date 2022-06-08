class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  ## user.provided_consultations returns all consultations,
  ## provided by user acting as DOCTOR
  has_many :provided_consultations, class_name: 'Consultation', dependent: :destroy, foreign_key: 'doctor_id'

  ## user.received_consultations returns all consultations,
  ## provided to a user acting as PATIENT
  has_many :received_consultations, class_name: 'Consultation', dependent: :destroy, foreign_key: 'patient_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = ["Doctor", "Patient", "Admin"]
  SPECIALTIES = ["Dermatology", "Nutrition", "General", "Psychology", "Otolaryngology",
                 "Allergy and immunology", "Emergency", "Neurology", "Pediatrics", "Urology",
                 "Ophthalmology", "Internal", "Onkology"]

  LANGUAGES = ["English", "Deutsch", "Français", "Español"]
  PREFIXES = ["Dr.", "Mr.", "Prof.", "Mrs.", "Ms."]

  validates :first_name, :last_name, :role, :country, :language, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ROLES }
end
