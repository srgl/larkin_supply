class Load < ActiveRecord::Base
  has_many :orders, -> { order(:order) }
  accepts_nested_attributes_for :orders

  enum delivery_shift: [:morning, :noon, :evening]

  validates :delivery_date, :delivery_shift, presence: true
  validate :delivery_shift_occupation, :volume_excess

  scope :ordered_by_date, -> { order(:delivery_date, :delivery_shift) }

  AVAILABLE_VOLUME = 1400

  def load_number
    date = '00000000'
    date = delivery_date.strftime('%Y%m%d')
    "L#{date}#{delivery_shift[0].upcase}"
  end

  def initial_volume
    orders.select{ |order| !order.return }.inject(0){ |v, order| v + order.volume }
  end

  def total_volume
    orders.inject(0){ |v, order| v + order.volume }
  end

  def delivery_shift_occupation
    loads = Load.where(delivery_shift: Load.delivery_shifts[delivery_shift], delivery_date: delivery_date)
    loads = loads.where.not(id: id) if id
    errors.add(:base, "Delivery shift is already occupied") if loads.count > 0
  end

  def volume_excess
    volume = initial_volume()
    if volume > AVAILABLE_VOLUME
      errors.add(:base, "Inital truckload exceeds available volume in truck (#{AVAILABLE_VOLUME}ft3)")
      return
    end

    orders.sort_by(&:order).each { |order|
      if !order.return
        volume -= order.volume
      else
        volume += order.volume
        if volume > AVAILABLE_VOLUME
          errors.add(:base, "Excess of available volume in truck (#{AVAILABLE_VOLUME}ft3) while processing return on stop #{order.order}")
          break
        end
      end
    }
  end

end
