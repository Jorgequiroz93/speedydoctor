class User < ApplicationRecord
  # for the favourites heart to work
  # for which model you want to be able to get favorited
  acts_as_favoritable
  # for which model can favorite other models
  acts_as_favoritor
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  ## user.provided_consultations returns all consultations,
  ## provided by user acting as DOCTOR
  has_many :provided_consultations, class_name: 'Consultation', dependent: :destroy, foreign_key: 'doctor_id'

  ## user.received_consultations returns all consultations,
  ## provided to a user acting as PATIENT
  has_many :received_consultations, class_name: 'Consultation', dependent: :destroy, foreign_key: 'patient_id'

  has_many :reviews, through: :provided_consultations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = ["Doctor", "Patient", "Admin"]
  SPECIALTIES = ["Dermatology", "Nutrition", "General", "Psychology", "Otolaryngology",
                 "Allergy and immunology", "Emergency", "Neurology", "Pediatrics", "Urology",
                 "Ophthalmology", "Internal", "Oncology"]

  LANGUAGES = ["English", "Deutsch", "Français", "Español"]
  PREFIXES = ["Dr.", "Mr.", "Prof.", "Mrs.", "Ms."]
  STATUS = ["Available", "Offline", "Busy"]

  validates :first_name, :last_name, :role, :country, :language, presence: true
  validates :email, uniqueness: true
  validates :role, inclusion: { in: ROLES }

  include PgSearch::Model
  pg_search_scope :search_globally,
                  against: [ :first_name, :last_name, :specialty, :country, :language ],
                  using: {
                    tsearch: { prefix: true }
                  }

  has_one_attached :photo

  def rating
    return reviews.empty? ? 2.0 : reviews.average('rating').round(1)
  end

  # def acts_as_favoritor
  #   user = User.find(1)

  #   # `user` favorites `user`.
  #   user.favorite(user)
  #   # `user` removes `user` from favorites.
  #   user.unfavorite(user)
  #   # Whether `user` has marked `user` as his favorite.
  #   user.favorited?(user)
  #   # Returns an Active Record relation of `user`'s `Favorite` records that have not been blocked.
  #   user.all_favorites
  #   # Returns an array of all unblocked favorited objects of `user`. This can be a collection of different object types, e.g.: `User`, `User`.
  #   user.all_favorited
  #   # Returns an Active Record relation of `Favorite` records where the `favoritable_type` is `user`.
  #   user.favorites_by_type('User')
  #   # Returns an Active Record relation of all favorited objects of `user` where `favoritable_type` is 'user'.
  #   user.favorited_by_type('User')
  #   # Returns the exact same as `user.favorited_by_type('User')`.
  #   user.favorited_users
  #   # Whether `user` has been blocked by `user`.
  #   user.blocked_by?(user)
  #   # Returns an array of all favoritables that blocked `user`.
  #   user.blocked_by
  # end

  # def acts_as_favoritable
  #   # Returns all favoritors of a model that `acts_as_favoritable`
  #   user.favoritors
  #   # Returns an Active Record relation of records with type `User` following `user`.
  #   user.favoritors_by_type('User')
  #   # Returns the exact same as `user.favoritors_by_type('User')`.
  #   user.user_favoritors
  #   # Whether `user` has been favorited by `user`.
  #   user.favorited_by?(user)
  #   # Block a favoritor
  #   user.block(user)
  #   # Unblock a favoritor
  #   user.unblock(user)
  #   # Whether `user` has blocked `user` as favoritor.
  #   user.blocked?(user)
  #   # Returns an array of all blocked favoritors.
  #   user.blocked
  # end
end
