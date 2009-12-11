require File.dirname(__FILE__) + '/../spec_helper'

describe Search do

  it { should have_column :site_address}
  it { should have_many :results }  
    
  describe "refresh" do
    before(:each) do
      @search = Search.create(:text => "Searchtext", :site_address => "http://google.com")
      @page = mock("page", :uri => "http://google.com",
                            :links_with => [
                              mock("link", :text => "Link 1", :href => "href 1" ),
                              mock("link", :text => "Link 2", :href => "href 2" )])
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
      @page.should_receive(:links_with).with(:text => /Searchtext/i).and_return(@page.links_with)
      @search.refresh
    end
    it "creates a result for each matching link if it doesn't exist" do
      @page.links_with.each do |link|
        @search.results.should_receive(:find_or_create_by_href).with(@page.uri + link.href, hash_including({
          :text => link.text,
          :href => @page.uri + link.href
        }))
      end
      @search.refresh
    end
    
    it "sets the refreshed_at time to now" do
      Time.stub!(:now).and_return(Time.parse("December 25, 2009 12:00"))
      @search.refreshed_at = Time.parse("December 1, 2009 12:00")
      @search.refresh
      @search.refreshed_at.should == Time.parse("December 25, 2009 12:00")
    end
  end
end
