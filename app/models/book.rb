class Book < ActiveRecord::Base
  enum state: {very_good: 0, good: 1, so_so: 2, bad: 3}

  belongs_to :o_user, :class_name => 'User', :foreign_key => 'o_user_id'
  belongs_to :e_user, :class_name => 'User', :foreign_key => 'e_user_id'
  belongs_to :user_detail
  has_many :orders, as: 'ordering'
  has_many :likes

  before_validation :add_js
  validates :title, presence: true
  validates :title, length: { maximum: 60 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # validates :state, presence: true

  mount_uploader :content, BookImageUploader
  acts_as_taggable_on :categories
  def tax
    (price + 200) * 0.08.round
  end

  def total_price
    (price + 200) * 1.08.round
  end

  scope :costry, -> { where("price > ?", 3000) }
  # Book.costry
  scope :writen_about, -> { where("name like ?", "%#{theme}") }
  # Book.costry.writen_about("Java")
  # =>「高価」で「Java」について書かれた本を探している

  # default_scope -> { order("created_at desc") }
  # => indexで代用

  def add_js
    self.title = self.title.gsub(/js/) do |matched|
    "javascript"
    end
  end

  after_destroy do |book|
    Rails.logger.info "Book is deleted: #{book.attributes.inspect}"
  end
end
