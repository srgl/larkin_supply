class Load < ActiveRecord::Base
	has_many :orders

	enum delivery_shift: [:morning, :noon, :evening]

  validates :delivery_date, :delivery_shift, presence: true

  def load_number
    "L#{delivery_date.strftime('%Y%m%d')}#{delivery_shift[0].upcase}"
  end
end
