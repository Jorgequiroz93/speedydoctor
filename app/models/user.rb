class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :consultations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = ["Doctor", "Patient", "Admin"]
  SPECIALTIES = ["Dermatology", "Nutrition", "General", "Psychology", "Otolaryngology",
                 "Allergy and immunology", "Emergency", "Neurology", "Pediatrics", "Urology",
                 "Ophthalmology", "Internal", "Onkology"]

  validates :first_name, :last_name, :role, :country, :language, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ROLES }
end
