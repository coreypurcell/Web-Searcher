class AddAddressColumnToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :site_address, :string
  end

  def self.down
    remove_column :searches, :site_address
  end
end
