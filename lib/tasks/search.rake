desc "Search for the specified products"
task :search => :environment do
  require 'mechanize'
  agent = WWW::Mechanize.new
  
  Search.all.each do |search|
    search.results.destroy_all
    agent.get(search.site_address)
    links = agent.page.links_with(:text => /#{search.text}/i)
    links.each do |l|
      search.results.create!(:text => l.text, :href => (agent.page.uri + l.href).to_s)      
    end
  end
end