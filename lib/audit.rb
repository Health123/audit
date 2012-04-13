require 'rails'

module Audit
  
  mattr_reader :current_user_method
  @@current_user_method = :current_user
  
  mattr_accessor :current_user
  @@current_user = nil
  
  mattr_accessor :current_user_ip
  @@current_user_ip = ''
  
  mattr_accessor :auditables
  @@auditables = []
  
  def self.setup
    yield self
  end
  
end

require 'audit/extensions/active_record/base'
require 'audit/extensions/action_controller/base'
require 'audit/engine'