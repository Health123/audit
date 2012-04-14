require 'spec_helper'

describe PagesController do
  it "should call set_audit_user_data" do
    controller.should_receive(:set_audit_user_data)
    get :index
  end
  
  context "user data" do
    before do
      controller.stub!(:current_user)
    end  
    
    it "should init object" do
      Audit.should_receive(:current_user=)
      get :index
    end
    
    it "should init IP address" do
      Audit.should_receive(:current_user_ip=)
      get :index
    end
  end  
end