class Search < ActiveRecord::Base
  attr_accessible :text, :site_address, :refreshed_at
  
  has_many :results, :autosave => true
  
  def refresh
    agent = WWW::Mechanize.new
    agent.get(self.site_address)
    links = agent.page.links_with( :text => /#{self.text}/i )
    links.each do |l|
      result = results.find_or_create_by_href(:text => l.text, :href => (agent.page.uri + l.href).to_s)
      result.touch
    end
    self.update_attribute(:refreshed_at, Time.now)
  end
end

# == Schema Information
#
# Table name: searches
#
#  id           :integer         not null, primary key
#  text         :text
#  created_at   :datetime
#  updated_at   :datetime
#  site_address :string(255)
#  refreshed_at :datetime
#

