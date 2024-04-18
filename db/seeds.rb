require 'csv'
require 'faker'

Customer.delete_all
Category.delete_all
Product.delete_all
Order.delete_all
OrderItem.delete_all
AdminUser.delete_all

# Fetch the file
filename = Rails.root.join("db/store_data.csv")

puts "Loading data from the CSV file #{filename}"

csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

products.each do |p|
  category = Category.find_or_create_by(name: p["category"])
  query = URI.encode_www_form_component(category.name)
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  product.image.attach(io: downloaded_image, filename: "m-#{category.name}.jpg")
  sleep(1)
  puts "Invalid category #{p['category']}: #{category.errors.full_messages.join(', ')}" unless category&.valid?

  if category && category.valid?
    product = category.products.create(
      name: p["name"],
      description: Faker::Lorem.paragraph,
      price: p["actual_price"],
      discounted_price: p["discount_price"],
      quantity: Faker::Number.positive
    )

    query = URI.encode_www_form_component([product.name, category.name].join(","))
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
    product.image.attach(io: downloaded_image, filename: "m-#{product.name}.jpg")
    sleep(1)

    unless product.valid?
      puts "Invalid product #{p['name']}"
      next
    end
  end
end

15.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  address = Faker::Address.street_address
  city = Faker::Address.city
  province = Faker::Address.state
  postal_code = Faker::Address.postcode
  phone_number = Faker::PhoneNumber.phone_number

  Customer.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    address: address,
    city: city,
    province: province,
    postal_code: postal_code,
    phone_number: phone_number
  )
end

20.times do
  order = Order.create(
    customer_id: Customer.pluck(:id).sample,
    total_price: Faker::Commerce.price(range: 50.0..200.0),
    status: ['pending', 'paid', 'shipped'].sample
  )

  rand(1..5).times do
    OrderItem.create(
      order_id: order.id,
      product_id: Product.pluck(:id).sample,
      quantity: Faker::Number.between(from: 1, to: 5),
      subtotal: Faker::Commerce.price(range: 10.0..100.0)
    )
  end
end

puts "Created #{Category.count} Categories"
puts "Created #{Product.count} Products"
puts "Created #{Customer.count} Customers"
puts "Created #{Order.count} Orders"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
