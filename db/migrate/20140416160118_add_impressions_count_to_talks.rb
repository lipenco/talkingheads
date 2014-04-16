class AddImpressionsCountToTalks < ActiveRecord::Migration
  def change
     add_column :talks, :impressions_count, :integer
  end
end
