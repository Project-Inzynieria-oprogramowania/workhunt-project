# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require_relative "../app/assets/config/initializers/work_constants.rb" 
100.times do 
    salary = rand(1..500)
    v = Vacancy.new(
        title: Faker::Job.title,
        description: Faker::Lorem.paragraphs(number: rand(2..5)).join("\n\n"),
        salary_min_cents: [salary * 1000, nil].sample,
        salary_max_cents: [(salary + rand(5..100)) * 1000, nil].sample,
        currency: %w[USD EUR].sample,
        country: Faker::Address.country,
        city: Faker::Address.city,
        skills_mandatory: Faker::Lorem.words(number: rand(3..5)).join('\n'),
        skills_optional: Faker::Lorem.words(number: rand(3..5)).join('\n'),
        experience: rand(0..10),
        job_type: JOB_TYPES.values.flatten.sample,
        education: EDUCATION.sample,
        subordination_level: SUBORDINATION_LEVEL.sample,
        contract_type: CONTRACT_TYPE.sample,
        working_time: WORKING_TIME.sample,
        work_type: WORK_TYPE.sample,
        status: 'Opened',
        organization_id: rand(1..3)
    )
    if v.save
        puts "Vacancy created successfully"
    else
        puts "Error creating vacancy: #{v.errors.full_messages.to_sentence}"
    end
end