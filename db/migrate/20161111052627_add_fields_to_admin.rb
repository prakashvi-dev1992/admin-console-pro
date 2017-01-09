class AddFieldsToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :first_name, :string
    add_column :admins, :last_name, :string
    add_column :admins, :city, :string
    add_column :admins, :mobile_number, :string
  end
end
