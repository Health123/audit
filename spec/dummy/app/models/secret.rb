class Secret < ActiveRecord::Base
  belongs_to :user
  attr_accessible :data, :user_id
end
