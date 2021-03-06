class UserResponse < ActiveRecord::Base

	belongs_to :entry
	belongs_to :user
	belongs_to :card

	validates_uniqueness_of :user, scope: :entry

	validates :user, presence: true
	validates :entry, presence: true
	validates :response, inclusion: { in: [true, false] }
	validates :response, exclusion: { in: [nil] }


	def self.to_csv
		attributes = %w[ 	id 
											stack_title 
											date
											group
											entry_title
											entry_question
											picture_id 
											user_id 
											user_age 
											user_gender 
											response 
											response_time
											prompt_help
											use_price ]

		CSV.generate(headers: true) do |csv|
			csv << attributes

			all.each do |user_response|
				csv << [	user_response.id,
									user_response.card.stack.title,
									user_response.created_at,
									user_response.user.group,
									user_response.entry.title,
									user_response.entry.question,
									user_response.entry.picture.id,
									user_response.user.id,
									user_response.user.age, 
									user_response.user.gender,
									user_response.response,
									user_response.response_time,
									user_response.user.feedback.prompt_help,
									user_response.user.feedback.would_use	]
			end
		end
	end


end