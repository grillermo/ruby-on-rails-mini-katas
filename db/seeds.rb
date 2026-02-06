# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Cleaning up database..."
Product.destroy_all

puts "Seeding products..."

1000.times do |i|
  product =Product.create!(
    name: Faker::Commerce.product_name,
    cost: Faker::Number.between(from: 10, to: 1000),
    description: Faker::Lorem.paragraph_by_chars(number: 1000)
  )

  10.times.each do 
    Variant.create(name: product.name + " #{Random.hex}", product: product)
  end

end

puts "Created #{Product.count} products."
