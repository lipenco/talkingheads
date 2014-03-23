class AddUserRefToConferences < ActiveRecord::Migration
  def change
    add_reference :conferences, :user, index: true
  end
end
