class Search < ActiveRecord::Base
  attr_accessible :text
  
  has_many :results
end
