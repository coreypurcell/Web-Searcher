require File.dirname(__FILE__) + '/../spec_helper'
include LayoutHelper

describe LayoutHelper do
  
  before(:each) do
    @content_for_title = "Content"
    @show_title = true
  end
  describe "title" do
    it "assigns instance varibles for the view" do   
      title('Content', true)
      assigns[:content_for_title] = @content_for_title
      assigns[:show_title] = @show_title
    end
  end
  describe "show_title" do
    it "returns the value of show_title" do
      show_title?.should == @show_title
    end
  end
  describe "stylesheet" do
    it "returns a stylesheet_tag for the stylesheets" do
      self.should_receive(:content_for).with(:head)
      stylesheet('test')
    end
  end
  describe "javascript" do
    it "returns a javascript_tag for the javascripts" do
      self.should_receive(:content_for).with(:head)
      javascript('test')
    end
  end
end