require 'spec_helper'

describe Result do
  before(:each) do
    @valid_attributes = {
      :href => "value for href",
      :text => "value for text"
    }
  end

  it "should create a new instance given valid attributes" do
    Result.create!(@valid_attributes)
  end
  
  it { should belong_to(:search) }
end

# == Schema Information
#
# Table name: results
#
#  id         :integer         not null, primary key
#  href       :string(255)
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  search_id  :integer
#

