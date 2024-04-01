class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :phone_number

      t.timestamps
    end
  end
end
