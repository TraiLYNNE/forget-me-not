class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_date
      t.integer :birth_year
      t.integer :user_id
    end
  end
end
