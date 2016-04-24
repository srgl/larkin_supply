class Load < ActiveRecord::Base
	has_many :orders, autosave: false

	enum delivery_shift: [:morning, :noon, :evening]

  validates :delivery_date, :delivery_shift, presence: true
  validate :delivery_shift_occupation, :volume_excess

  AVAILABLE_VOLUME = 1400

  def load_number
    date = '00000000'
    date = delivery_date.strftime('%Y%m%d') if delivery_date
    "L#{date}#{delivery_shift[0].upcase}"
  end

  def delivery_shift_occupation
    puts self.attributes
    loads = Load.where(delivery_shift: Load.delivery_shifts[delivery_shift], delivery_date: delivery_date)
    loads = loads.where.not(id: id) if id
    errors.add(:base, "Delivery shift is already occupied") if loads.count > 0
  end

  def volume_excess
    # if orders.where(load_id: id).sum(:volume) > AVAILABLE_VOLUME
    #   errors.add(:base, "Available volume exceeded")
    # end
    errors.add(:base, "Available volume exceeded") if orders.size() > 3
  end
end
