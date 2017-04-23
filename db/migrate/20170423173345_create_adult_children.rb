class CreateAdultChildren < ActiveRecord::Migration
  def change
    create_table :adult_children do |t|
      t.integer :adult_id
      t.integer :child_id
    end
  end
end
