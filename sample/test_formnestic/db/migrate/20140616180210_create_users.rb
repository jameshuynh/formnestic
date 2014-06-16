class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :account_id
      t.string :name
      t.string :description
      t.date :birthday
      t.string :gender

      t.timestamps
    end
  end
end
