class Order < ActiveRecord::Base
	enum delivery_shift: [:morning, :noon, :evening]
	enum mode: [:truckload]
	enum handling_unit_type: [:box]
end
