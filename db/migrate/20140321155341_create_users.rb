class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :uid
      t.string :provider

      t.timestamps
    end
  end
end
