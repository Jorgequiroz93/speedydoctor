class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :consultations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES: ["Doctor", "Patient"]

  validates :first_name, :last_name, :role, :country, :language, presence: true
  validate :email, uniqueness: true
  validates :role, inclusion: {in: ROLES}
end
