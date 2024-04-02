15.times do
  Customer.create(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address
  )
end

10.times do
  Category.create(
    name: Faker::Commerce.department(max: 1)
  )
end

100.times do
  Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 10.0..100.0),
    category_id: Category.pluck(:id).sample
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
