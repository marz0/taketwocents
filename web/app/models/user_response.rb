class UserResponse < ActiveRecord::Base

	belongs_to :entry
	belongs_to :user
	belongs_to :stack, through: :entry

	validates_uniqueness_of :user, scope: :entry

	validates :user, presence: true
	validates :entry, presence: true
	validates :response, presence: true

end