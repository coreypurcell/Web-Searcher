desc "Search for the specified products"
task :search => :environment do
  require 'mechanize'
  agent = WWW::Mechanize.new
  
  Search.all.each do |search|
    search.refresh
  end
end

desc "Cron task for Heroku"
task :cron => :environment do
  Rake::Task["search"].invoke
end