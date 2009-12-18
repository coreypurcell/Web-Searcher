class Result < ActiveRecord::Base
  belongs_to :search, :autosave => true
end

# == Schema Information
#
# Table name: results
#
#  id         :integer         not null, primary key
#  href       :string(255)
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  search_id  :integer
#

