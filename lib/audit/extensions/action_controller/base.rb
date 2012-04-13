module Audit
  module ActionController
    def self.included(base)
      unless base.included_modules.include?(InstanceMethods)
        base.send :include, InstanceMethods
      end
    end

    module InstanceMethods
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
end

::ActionController::Base.send(:include, ::Audit::ActionController)