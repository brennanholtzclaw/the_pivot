class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  validates :status, presence: true
  #status of the order (ordered, paid, cancelled, completed)

  def formatted_date
    created_at.strftime("%B %-d, %Y")
  end

  def total
    line_items.inject(0) do |total, line_item|
      total + line_item.subtotal
    end
  end

  def formatted_total
    number_to_currency(total)
  end
end
