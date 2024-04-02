class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_price
      t.datetime :order_date
      t.string :status

      t.timestamps
    end
  end
end