class CreateStaticPages < ActiveRecord::Migration
  def change
    create_table :static_pages do |t|
      t.string :name
      t.string :content
      t.string :page_route
      t.string :label

      t.timestamps null: false
    end
  end
end
