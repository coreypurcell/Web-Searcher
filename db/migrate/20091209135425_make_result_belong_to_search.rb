class MakeResultBelongToSearch < ActiveRecord::Migration
  def self.up
    add_column :results, :search_id, :integer
  end

  def self.down
    remove_column :results, :search_id
  end
end
