class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.string :slides_url
      t.string :speaker
      t.references :conference, index: true

      t.timestamps
    end
  end
end
