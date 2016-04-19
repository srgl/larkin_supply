class Order < ActiveRecord::Base
	belongs_to :load

	enum delivery_shift: [:morning, :noon, :evening]
	enum mode: [:truckload]
	enum handling_unit_type: [:box]
end
