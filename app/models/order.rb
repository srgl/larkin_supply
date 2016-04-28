class Order < ActiveRecord::Base
	belongs_to :load

	enum delivery_shift: [:morning, :noon, :evening]
	enum mode: [:truckload]
	enum handling_unit_type: [:box]

  scope :ordered_by_date, -> { order(:delivery_date, :delivery_shift) }

  def origin_address
    "#{origin_raw_line_1}, #{origin_city}, #{origin_state} #{origin_zip}"
  end

  def destination_address
    "#{destination_raw_line_1}, #{destination_city}, #{destination_state} #{destination_zip}"
  end

end
