require File.dirname(__FILE__) + '/../spec_helper'
 
describe SearchesController do
  before(:each) do
    @search = mock_model(Search)
    Search.stub!(:find).and_return(@search)
  end
  
  describe "handling GET index" do
    before(:each) do
      @searches = [@search]
    end
    
    def do_get
      get :index  
    end
    
    it "should find all searches and assign them for the view" do
      Search.should_receive(:all).and_return(@searches)
      do_get
      assigns[:searches].should == @searches
    end
    
    it "should render the index template" do
      do_get
      response.should render_template(:index)
    end
    
  end

  describe "handling GET new" do
    
    def do_get
      get :new
    end
    
    it "should build an empty search and assign it for the view" do
      Search.should_receive(:new).and_return(@search)
      do_get
      assigns[:search].should == @search
    end
    
    it "should render the new template" do
      do_get
      response.should render_template(:new)
    end
  end

  describe "handling POST create" do
    before(:each) do
      Search.stub!(:new).and_return(@search)
    end
    
    def post_with_valid_attributes
      @search.should_receive(:save).and_return(true)
      post :create, :search => {:text => 'a_new_search'}
    end
    
    def post_with_invalid_attributes
      @search.should_receive(:save).and_return(false)
      post :create
    end
    
    it "builds a new Search from params and assigns it for the view" do
      Search.should_receive(:new).with("text" => 'a_new_search').and_return(@search)
      post_with_valid_attributes
      assigns[:search].should == @search
    end
      
    it "sets flash and redirects to the index action on success" do
      post_with_valid_attributes
      flash[:notice].should == 'Search created.'
      response.should redirect_to(searches_path)
    end
    
    it "sets the flash and renders the new template on failure" do
      post_with_invalid_attributes
      response.should render_template(:new)
    end
    
  end

  describe "handling GET edit" do
    
    def do_get
      get :edit, :id => 37
    end
    
    it "should find the specified search and assign it for the view" do
      Search.should_receive(:find).with("37").and_return(@search)
      do_get
      assigns[:search].should == @search
    end
    it "should render the edit template" do
      do_get
      response.should render_template(:edit)
    end
  end

  describe "handling PUT update" do
    
    def put_with_valid_attributes
      @search.should_receive(:update_attributes).and_return(true)
      put :update, :id => 34, :search => {:description => "an updated search"}
    end
    
    def put_with_invalid_attributes
      @search.should_receive(:update_attributes).and_return(false)
      put :update, :id => 34
    end
    
    it "finds the specified search and assigns it for the view" do
      Search.should_receive(:find).with('34').and_return(@search)
      put_with_valid_attributes
      assigns[:search].should == @search
    end
    
    it "should set the flash and redirect to the index if success" do
      put_with_valid_attributes
      response.should redirect_to(searches_path)
      flash[:notice].should == 'Search updated.'
    end
    
    it "should render the edit template if failure" do
      put_with_invalid_attributes
      response.should render_template(:edit)
    end
  end

  describe "handling DELETE destroy" do
    before(:each) do
      @search.stub!(:destroy).and_return(true)
    end
    
    def do_delete
      delete :destroy, :id => 35
    end
    
    it "finds the specified search" do
      Search.should_receive(:find).with("35").and_return(@search)
      do_delete
    end
    
    it "destroys the shipment" do
      @search.should_receive(:destroy)
      do_delete
    end
    
    it "sets the flash and redirects to the index" do
      do_delete
      response.should redirect_to(searches_path)
      flash[:notice].should == "Search deleted."
    end
  end
end
