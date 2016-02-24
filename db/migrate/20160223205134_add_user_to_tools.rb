class AddUserToTools < ActiveRecord::Migration
  def change
    add_reference :tools, :user, index: true, foreign_key: true
  end
end
