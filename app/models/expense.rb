class Expense < ActiveRecord::Base

  belongs_to :user

  belongs_to :category

  has_many :taggings
  has_many :tags, through: :taggings

  validates :user_id, presence: true

end
