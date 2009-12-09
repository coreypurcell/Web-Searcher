require File.dirname(__FILE__) + '/../spec_helper'

describe Search do

  it { should have_column :site_address}
  it { should have_many :results }  
    
end
