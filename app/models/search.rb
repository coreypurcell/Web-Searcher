class Search < ActiveRecord::Base
  attr_accessible :text, :site_address
  
  has_many :results
  
  def refresh
    self.results.destroy_all
    agent = WWW::Mechanize.new
    agent.get(self.site_address)
    links = agent.page.links_with( :text => /#{self.text}/i )
    links.each do |l|
      self.results.create!(:text => l.text, :href => (agent.page.uri + l.href).to_s)   
    end
  end
end
