# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
# require "open-uri"

# Patients:

Report.destroy_all
Review.destroy_all
Consultation.destroy_all
User.destroy_all

## special users
##----------------- doctor house for live consultation
doctor = User.create!(email: "doctor@gmail.com", date_of_birth: 40.years.ago, password:"123123", first_name: "Gregory", last_name: "House", country: "US", language: "English", role: "Doctor", rate: 2.5, specialty: "General", sub_specialty: "Diagnostics", skills: "Piss people off.", prefix: "Dr.", status: "Offline")
file = File.open(Rails.root.join("app/assets/images/doctors/doc0.jpg"))
doctor.photo.attach(io: file, filename: "doc0.jpg", content_type: 'images/doctors/jpg')
##----------------- manon's profile
patient = User.create!(email: "patient@gmail.com", date_of_birth: 34.years.ago, password:"123123", first_name: "Manon", last_name: "Aidinian", country: "France", language: "English", role: "Patient", prefix: "Mrs.")
file = File.open(Rails.root.join("app/assets/images/manon-avatar.png"))
patient.photo.attach(io: file, filename: "manon-avatar.jpg", content_type: 'images/png')

##----------------- doctor for creating an old consultation
doctor2 = User.create!(email: "doctor2@gmail.com", date_of_birth: 45.years.ago, password:"123123", first_name: "Meredith", last_name: "Grey", country: "US", language: "English", role: "Doctor", rate: 2.2, specialty: "General", sub_specialty: "Diagnostics", skills: "Can heal anything", prefix: "Dr.", status: "Busy")
file = File.open(Rails.root.join("app/assets/images/doctors/meredith.jpg"))
doctor2.photo.attach(io: file, filename: "meredith.jpg", content_type: 'images/doctors/jpg')


p start_time = Faker::Time.backward(days: 14, period: :evening)
p session_time = 25
p num_minutes = session_time.minutes
p end_time = start_time + num_minutes

consultation = Consultation.create!(
  patient_id: patient.id,
  doctor_id: doctor2.id,
  symptoms: Faker::Lorem.sentence(word_count: 10),
  status: Consultation::STATUSES.sample,
  start_time: start_time,
  end_time: end_time,
  total_price: (session_time * doctor2.rate).round(2)
)

professionalism_rating = rand(2..5)
speed_rating = rand(2..5)
clarity_rating = rand(2..5)
gentleness_rating = rand(2..5)
rating = (professionalism_rating + speed_rating + clarity_rating + gentleness_rating) / 4.0

Review.create!(
  content: "Dr. Grey has been very kind, her magical pills were amazing.",
  professionalism_rating: professionalism_rating,
  speed_rating: speed_rating,
  clarity_rating: clarity_rating,
  gentleness_rating: gentleness_rating,
  rating: rating,
  consultation: consultation
)

Report.create!(
  content: "Manon showed some loss memories issues since the start of her bootcamp",
  prescription: "I diagnosed it is due to the size of her brain that can't store that much information and prescribed her some magical coding pills",
  consultation: consultation
)

# consultation = Consultation.create!(doctor_id: doctor.id, patient_id: patient.id)

patients = []

10.times do
  patients << User.create!(
    role: "Patient",
    prefix: Faker::Name.prefix,
    date_of_birth: Faker::Date.birthday(min_age: 16, max_age: 100),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123",
    country: Faker::Address.country,
    language: Faker::Nation.language
  )
end


# Doctors:
doctors = []
i = 1
User::SPECIALTIES.each do |specialty|
  rand(2..3).times do
    doctor = User.create!(
      role: "Doctor",
      specialty: specialty,
      prefix: ["Dr.", "Prof"].sample,
      date_of_birth: Faker::Date.birthday(min_age: 16, max_age: 100),
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      status: User::STATUS.sample,
      password: "123123",
      diplomas: ["Doctor of Optometr (OD) Program", "Doctor Osteopatic Medicine", "Medicine and pharmacy", "Clinical Medical Assistant training", "MBBS – Bachelor of Medicine, Bachelor of Surgery.", "BDS – Bachelor of Dental Surgery.", "BAMS – Bachelor of Ayurvedic Medicine and Surgery.", "BHMS – Bachelor of Homeopathy Medicine and Surgery."].sample(2).join(", "),
      country: Faker::Address.country,
      language: Faker::Nation.language,
      rate: rand(0.1..10.0),
      sub_specialty: Faker::Science.science(:natural),
      skills: ["aesthetic dermatology", "Intense pulsed light - ipl", "Hydrafacial",
               "hair mesotherapy", "Oxygeneo facial", "Peeling", "Microneedle therapy for scars",
               "co2 laser", "fractional co2 laser", "co2 laser for rejuvenation",
               "Facial biostimulation", "Anti-aging aesthetic treatment", "skin care treatment",
               "mole removal", "wart removal"].sample(6).join(", ")
    )
    file = File.open(Rails.root.join("app/assets/images/doctors/doc#{i % 10}.jpg"))
    doctor.photo.attach(io: file, filename: "doc#{i % 10}.jpg", content_type: 'images/doctors/jpg')
    doctors << doctor
    i += 1
    puts User.count
  end
end

# Consultations:
consultation = []

patients.each do |patient|
  rand(1..4).times do
    p start_time = Faker::Time.backward(days: 14, period: :evening)
    p session_time = rand(5..60)
    p num_minutes = session_time.minutes
    p end_time = start_time + num_minutes
    doctor = doctors.sample

    consultation = Consultation.create!(
      patient_id: patient.id,
      doctor_id: doctor.id,
      symptoms: Faker::Lorem.sentence(word_count: 10),
      status: Consultation::STATUSES.sample,
      start_time: start_time,
      end_time: end_time,
      total_price: (session_time * doctor.rate).round(2)
    )

    professionalism_rating = rand(2..5)
    speed_rating = rand(2..5)
    clarity_rating = rand(2..5)
    gentleness_rating = rand(2..5)
    rating = (professionalism_rating + speed_rating + clarity_rating + gentleness_rating) / 4.0

    p Review.create!(
      content: Faker::Lorem.sentence(word_count: 15),
      professionalism_rating: professionalism_rating,
      speed_rating: speed_rating,
      clarity_rating: clarity_rating,
      gentleness_rating: gentleness_rating,
      rating: rating,
      consultation: consultation
    )

    Report.create!(
      content: Faker::Lorem.sentence(word_count: 25),
      prescription: Faker::Lorem.sentence(word_count: 25),
      consultation: consultation
    )
  end
end
