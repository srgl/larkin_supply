class Order < ActiveRecord::Base
	belongs_to :load

	enum delivery_shift: [:morning, :noon, :evening]
	enum mode: [:truckload]
	enum handling_unit_type: [:box]

  scope :ordered_by_date, -> { order(:delivery_date, :delivery_shift) }

end
