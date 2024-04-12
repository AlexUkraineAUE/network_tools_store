require 'faker'

Customer.destroy_all
Category.destroy_all
Product.destroy_all
Order.destroy_all
OrderItem.destroy_all
AdminUser.destroy_all

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

10.times do
  Category.create(
    name: Faker::Commerce.department
  )
end

100.times do

  name = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph
  price = Faker::Commerce.price(range: 10.0..100.0)
  category_id = Category.pluck(:id).sample
  quantity = Faker::Number.positive

  product = Product.create(
    name: name,
    description: description,
    price: price,
    category_id: category_id,
    quantity: quantity
  )

  query = URI.encode_www_form_component([product.name].join(","))
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  product.image.attach(io:downloaded_image, filename: "m-#{[product.name].join("-")}.jpg")
  sleep(1)

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
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
