class Task < ActiveRecord::Base
has_many :comments
validates :description, presence: true
belongs_to :project
end
