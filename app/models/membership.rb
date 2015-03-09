class Membership < ActiveRecord::Base

#sets member to 0 and owner to 1 in the database
enum role: [:member, :owner]
belongs_to :user
belongs_to :project

validates :role, presence: true
validates :user_id, presence: true
validate :duplication

def duplication
  unless user_id == project.users.find(user_id)
    
end

end
