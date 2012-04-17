module Audit
  module ActionController
    extend ActiveSupport::Concern
    
    def included
      before_filter :set_audit_user_data
    end

    
    def self.included(base)
      base.send :before_filter, :set_audit_user_data
    end

    protected

    def set_audit_user_data
      Audit.current_user    = self.respond_to?(Audit.current_user_method) ? self.send(Audit.current_user_method) : nil
      Audit.current_user_ip = self.request.remote_ip
    end
  end
end

ActionController::Base.send(:include, Audit::ActionController)