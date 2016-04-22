class Load < ActiveRecord::Base
	has_many :orders

	enum delivery_shift: [:morning, :noon, :evening]

  validates :delivery_date, :delivery_shift, presence: true
  validate :delivery_shift_occupation, :volume_excess

  AVAILABLE_VOLUME = 1400

  def load_number
    "L#{delivery_date.strftime('%Y%m%d')}#{delivery_shift[0].upcase}"
  end

  def delivery_shift_occupation
    loads = Load.where(delivery_shift: delivery_shift, delivery_date: delivery_date)
    loads = loads.where.not(id: id) if id
    errors.add(:base, "Delivery shift is already occupied") if loads.count > 0
  end

  def volume_excess
    if orders.where(load_id: id).sum(:volume) > AVAILABLE_VOLUME
      errors.add(:base, "Available volume exceeded")
    end
  end
end
