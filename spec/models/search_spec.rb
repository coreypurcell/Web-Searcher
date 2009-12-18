require File.dirname(__FILE__) + '/../spec_helper'

describe Search do

  it { should have_column :site_address}
  it { should have_many :results }  
    
  describe "refresh" do
    before(:each) do
      @search = Search.create(:text => "Link", :site_address => "http://google.com")
      @page = mock("page", :uri => "http://google.com")
      @links =[ mock("link", :text => "Link 1", :href => "href 1" ),
                mock("link", :text => "Link 2", :href => "href 2" )] 
      @page.stub!(:links_with).with(hash_including(:text => /Link/i)).and_return(@links)
      @agent = mock("agent", :get => @page)
      WWW::Mechanize.stub!(:new).and_return(@agent)
      @agent.stub!(:page).and_return(@page)
    end
    it "gets fetches the page in the site_address" do
      WWW::Mechanize.should_receive(:new).and_return(@agent)
      @agent.should_receive(:get).with("http://google.com")
      @search.refresh
    end
    it "finds all links that match the expression in text attribute" do
      @page.should_receive(:links_with).with(:text => /Link/i)
      @search.refresh
    end
    it "creates a result for each matching link if it doesn't exist" do
      @search.results.size.should == 0
      @search.refresh
      @search.reload
      @search.results.size.should == 2  
    end
    
    it "updates all links\' updated_at to now" do
      Time.stub!(:now).and_return(Time.parse("December 25, 2009 12:00"))      
      @search.results.create!(:text => "Link 1", :href => "href 1", :updated_at  => Time.parse("December 1, 2009 12:00"))
      p Result.all
      @search.refresh
      @search.reload
      p Result.all
      Result.find_by_href("href 1").updated_at.should > Time.parse("December 1, 2009 12:00")
      
    end
    
    it "sets the refreshed_at time to now" do
      Time.stub!(:now).and_return(Time.parse("December 25, 2009 12:00"))
      @search.refreshed_at = Time.parse("December 1, 2009 12:00")
      @search.refresh
      @search.reload.refreshed_at.should == Time.parse("December 25, 2009 12:00")
    end
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

