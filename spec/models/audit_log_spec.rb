require 'spec_helper'

describe Audit::AuditLog do
  
  let(:user)    { create(:user) }
  let(:user2)   { create(:user) }
  let(:secret)  { create(:secret) }
  let(:secret2) { create(:secret2, user: user) }
  let(:log)     { secret.audit_logs.last }
  
  def self.should_create_with_correct_data
    it "should create with current user" do
      log.user.should == user 
    end
    
    it "should create with user IP" do
      log.ip_address.should == '127.0.0.1'
    end
  end
  
  it { should belong_to(:user) }
  it { should belong_to(:auditable) }

  before do
    Audit.current_user    = user
    Audit.current_user_ip = '127.0.0.1'
  end
  
  describe "except owner" do
    before(:all) do
      Secret2.acts_as_auditable(except: :owner, owner: :user)
    end
    
    it "should not create AuditLog" do
      expect { secret2 }.to_not change(Audit::AuditLog, :count).by(1)
    end
    
    it "should create AuditLog if not owner" do
      secret2
      Audit.current_user = user2
      expect { Secret2.find(secret2.id) }.to change(Audit::AuditLog, :count).by(1)
    end
  end  
  
  describe "audit all" do
    before(:all) do
      Secret.acts_as_auditable
    end  

    context "audit creation" do
      it "should create AuditLog" do
        expect { secret }.to change(Audit::AuditLog, :count).by(1)
      end

      it "should have create action" do
        log.action.should == 'create'
      end  

      should_create_with_correct_data    
    end      

    context "audit updating" do
      before do
        secret
      end  

      it "should create AuditLog" do
        expect { secret.update_attributes(data: 'Change data') }.to change(Audit::AuditLog, :count).by(1)
      end

      context "should create with correct data" do
        before do
          secret.update_attributes(data: 'Change data')
        end

        it "should have create action" do
          log.action.should == 'update'
        end

        should_create_with_correct_data
      end  
    end

    context "audit destroying" do
      before do
        secret
      end

      it "should create AuditLog" do
        expect { secret.destroy }.to change(Audit::AuditLog, :count).by(1)
      end

      context "should create with correct data" do
        before do
          secret.destroy
        end

        it "should have create action" do
          log.action.should == 'destroy'
        end

        should_create_with_correct_data
      end
    end

    context "audit finding" do
      before do
        secret
      end

      it "should create AuditLog" do
        expect { Secret.find(secret.id) }.to change(Audit::AuditLog, :count).by(1)
      end

      context "should create with correct data" do
        before do
          Secret.find(secret.id)
        end

        it "should have create action" do
          log.action.should == 'find'
        end

        should_create_with_correct_data
      end
    end
  end
end  