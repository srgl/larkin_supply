class Order < ActiveRecord::Base
	belongs_to :load

	enum delivery_shift: [:morning, :noon, :evening]
	enum mode: [:truckload]
	enum handling_unit_type: [:box]

  scope :ordered_by_ids, ->(ids) { order("id in (#{ids.join(',')}) desc") }
  scope :ordered_by_date, -> { order(:delivery_date, :delivery_shift) }
  scope :ordered_by_ids_and_date, -> (ids) {
    orders = all
    orders = orders.ordered_by_ids(ids) if ids.any?
    orders.ordered_by_date
  }

end
