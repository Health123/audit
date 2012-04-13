module Audit
  module ActiveRecord

    def self.included(base)
      unless base.included_modules.include?(InstanceMethods)
        base.extend ClassMethods
      end
    end

    module InstanceMethods
      def audit(action)
        user  = Audit.current_user
        ip    = Audit.current_user_ip
        
        unless self.class.audit_config[:except].to_s == 'owner' and 
          self.class.audit_config[:owner].present? and
          self.respond_to?(self.class.audit_config[:owner]) and
          self.call(self.class.audit_config[:owner]) == user
        
          self.audit_logs.create({
            user: user,
            ip_address: ip,
            action: action.to_s
          })
        end
        
        true
      end
    end

    module ClassMethods
      def acts_as_auditable(options = {})
        @audit_config = options
        has_many :audit_logs, as: :auditable, class_name: '::Audit::AuditLog'
        after_create    {|record| record.audit(:create)}
        after_update    {|record| record.audit(:update)}
        after_find      {|record| record.audit(:find)}
        before_destroy  {|record| record.audit(:destroy)}
        
        register_auditable(self)
        include InstanceMethods
        
        true
      end

      def audit_config
        @audit_config ||= {}
      end

      protected

      def register_auditable(klass)
        Audit.auditables = (Audit.auditables << klass.name).uniq
      end
    end
  end
end

::ActiveRecord::Base.send(:include, ::Audit::ActiveRecord)