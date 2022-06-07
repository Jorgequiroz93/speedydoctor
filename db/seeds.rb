# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

# Patients:

Report.destroy_all
Review.destroy_all
Consultation.destroy_all
User.destroy_all

patients = []
10.times do
  patients << User.create!(
    role: "Patient",
    prefix: Faker::Name.prefix,
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
User::SPECIALTIES.each do |specialty|
  rand(2..10).times do
    doctors << User.create!(
      role: "Doctor",
      specialty: specialty,
      prefix: ["Dr.", "Prof"].sample,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: "123123",
      country: Faker::Address.country,
      language: Faker::Nation.language,
      rate: rand(0.1..10.0),
      sub_specialty: Faker::Science.science(:natural),
      skills: ["aesthetic dermatology", "Intense pulsed light - ipl", "Hydrafacial",
               "hair mesotherapy", "Oxygeneo facial", "Peeling", "Microneedle therapy for scars",
               "co2 laser", "fractional co2 laser", "co2 laser for rejuvenation",
               "Facial biostimulation", "Anti-aging aesthetic treatment", "skin care treatment",
               "mole removal", "wart removal"]
    )
  end
end

# Consultations:
consultations = []

patients.each do |patient|
  rand(1..4).times do
    p start_time = Faker::Time.backward(days: 14, period: :evening)
    p num_minutes = rand(1..60).minutes
    p end_time = start_time + num_minutes
    doctor = doctors.sample

    consultation = Consultation.create!(
      patient_id: patient.id,
      doctor_id: doctor.id,
      symptoms: Faker::Lorem.sentence(word_count: 10),
      status: Consultation::STATUSES.sample,
      start_time: start_time,
      end_time: end_time,
      total_price: num_minutes * doctor.rate
    )

    professionalism_rating = rand(1.0..5.0)
    speed_rating = rand(1.0..5.0)
    clarity_rating = rand(1.0..5.0)
    gentleness_rating = rand(1.0..5.0)
    rating = (professionalism_rating + speed_rating + clarity_rating + gentleness_rating) / 4

    Review.create!(
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
