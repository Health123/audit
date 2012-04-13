module Audit
  class AuditLog < ::ActiveRecord::Base
    belongs_to :user, polymorphic: true
    belongs_to :auditable, polymorphic: true
  end  
end  