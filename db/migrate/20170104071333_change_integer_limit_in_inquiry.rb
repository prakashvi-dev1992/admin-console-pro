class ChangeIntegerLimitInInquiry < ActiveRecord::Migration
  def change
    change_column :inquiries, :phone, :integer, limit: 8
  end
end
