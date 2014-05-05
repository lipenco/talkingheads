class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :talks, :slides_url, :text
  end
end
