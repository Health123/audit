class Secret2 < ActiveRecord::Base
  belongs_to :user
  attr_accessible :data, :user_id
end
