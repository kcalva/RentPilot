desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  starting = Time.now
  p "Clearing old data..."
  Message.delete_all
  Payment.delete_all
  Lease.delete_all
  Unit.delete_all
  Property.delete_all
  User.delete_all

  p "Seeding users..."
  User.create!(
    name: "LandLord Kevin",
    email: "landlord-kevin@example.com",
    password: "password",
    role: "landlord",
  )

  User.create!(
    name: "Tenant Kevin",
    email: "tenant-kevin@example.com",
    password: "password",
    role: "tenant",
  )

  9.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: "password",
      role: "landlord",
    )
  end

  39.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: "password",
      role: "tenant",
    )
  end

  landlords = User.where(role: "landlord")
  tenants = User.where(role: "tenant")

  p "Seeding properties..."
  landlords.each do |landlord|
    2.times do
      Property.create!(
        name: Faker::Address.community,
        address: Faker::Address.full_address,
        landlord: landlord,
      )
    end
  end

  properties = Property.all

  p "Seeding units..."
  tenants.each do |tenant|
    property = properties.sample
    Unit.create!(
      property: property,
      unit_number: Faker::Number.number(digits: 4),
      tenant: tenant,
    )
  end

  p "Seeding leases..."
  tenants.each do |tenant|
    unit = Unit.find_by(tenant: tenant)
    # Create one current lease
    Lease.create!(
      unit: unit,
      tenant: unit.tenant,
      start_date: Faker::Date.backward(days: 60),
      end_date: Faker::Date.forward(days: 300),
      rent_amount: Faker::Commerce.price(range: 500..1500),
      security_deposit: Faker::Commerce.price(range: 500..1500),
    )

    # Create past leases
    2.times do
      Lease.create!(
        unit: unit,
        tenant: unit.tenant,
        start_date: Faker::Date.backward(days: 365),
        end_date: Faker::Date.backward(days: 60),
        rent_amount: Faker::Commerce.price(range: 500..1500),
        security_deposit: Faker::Commerce.price(range: 500..1500),
      )
    end
  end

  p "Seeding payments..."
  leases = Lease.all
  leases.each do |lease|
    3.times do
      status = %w[pending paid overdue].sample
      Payment.create!(
        unit: lease.unit,
        tenant: lease.tenant,
        amount: Faker::Commerce.price(range: 500..1500),
        due_date: Faker::Date.between(from: 1.month.ago, to: Date.today),
        paid_at: status == "paid" ? Faker::Date.between(from: 1.month.ago, to: Date.today) : nil,
        status: status,
      )
    end
  end

  p "Seeding messages..."
  50.times do
    Message.create!(
      sender: tenants.sample,
      receiver: landlords.sample,
      content: Faker::Lorem.sentence,
    )
  end

  ending = Time.now

  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{Property.count} properties."
  p "There are now #{Unit.count} units."
  p "There are now #{Lease.count} leases."
  p "There are now #{Payment.count} payments."
  p "There are now #{Message.count} messages."
end
