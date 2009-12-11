class AddRefreshDateTimeToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :refreshed_at, :datetime
  end

  def self.down
    remove_column :searches, :refreshed_at
  end
end
