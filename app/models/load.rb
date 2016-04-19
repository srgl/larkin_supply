class Load < ActiveRecord::Base
	has_many :orders

	enum delivery_shift: [:morning, :noon, :evening]
end
