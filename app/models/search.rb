class Search < ActiveRecord::Base
  attr_accessible :text, :site_address
  
  has_many :results
end
