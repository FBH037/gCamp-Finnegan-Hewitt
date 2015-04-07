class Membership < ActiveRecord::Base

#sets member to 0 and owner to 1 in the database
enum role: [:member, :owner]
belongs_to :user
belongs_to :project

validates :role, presence: true
validates :user_id, presence: true
validate :duplication, on: :create

  def duplication
    if user_id
      if project.users.find_by_id(user_id)
        errors[:base] << "User has already been added to this project"
      end
    end
  end

end
