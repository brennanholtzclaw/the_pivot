class Category < ActiveRecord::Base
  has_many :category_items
  has_many :items, through: :category_items
  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :image, presence: true

  before_validation :generate_slug

  def non_retired_items
    items.where(retired: false)
  end

  def generate_slug
    self.slug = title.parameterize if title
  end
end
