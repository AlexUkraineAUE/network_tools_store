class CreateSiteContents < ActiveRecord::Migration[7.1]
  def change
    create_table :site_contents do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
