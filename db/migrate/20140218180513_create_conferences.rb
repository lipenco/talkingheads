class CreateConferences < ActiveRecord::Migration
  def up
    create_table :conferences do |t|
      t.string :name
      t.string :tags
      t.date :date
      t.string :organizer
      t.string :place
      t.text :description

      t.timestamps
    end
  end
  def down
    drop_table :conferences
  end
end
