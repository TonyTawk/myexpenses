class Expense < ActiveRecord::Base

  belongs_to :user

  belongs_to :category

  has_many :taggings
  has_many :tags, through: :taggings

  validates :user_id, presence: true

  def self.search(search , user_id)
    if search
      self.where('(title LIKE ? OR description LIKE ?) AND user_id = ?', "%#{search}%" , "%#{search}%" , user_id)
    else
      self.where(:user_id => user_id)
    end
  end

end
