class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :skype_id
      t.integer :phone
      t.text :message

      t.timestamps null: false
    end
  end
end
