class Expense < ActiveRecord::Base

  belongs_to :user

  belongs_to :category

  has_many :taggings
  has_many :tags, through: :taggings

  validates :user_id, presence: true

  def self.filter(search, type, tag, category, start_time, end_time, user_id)
    if search
      self.where('(title LIKE ? OR description LIKE ?) AND user_id = ?', "%#{search}%", "%#{search}%", user_id)
    elsif type
      self.where('expense_type = ? AND user_id = ? ', type, user_id)
    elsif tag || category
      if tag && category
        self.joins(:tags).joins(:category).where('tags.url_name  = ? AND categories.url_name = ? AND user_id = ?', tag, category, user_id)
      elsif tag
        self.joins(:tags).where('tags.url_name  = ?  AND user_id = ?', tag, user_id)
      elsif category
        self.joins(:category).where('categories.url_name = ? AND user_id = ?', category, user_id)
      end
    elsif start_time || end_time
      if start_time && end_time
        self.where('time between ? AND ? AND user_id = ? ', start_time , end_time, user_id)
      elsif start_time
        self.where('time > ? AND user_id = ? ', start_time, user_id)
      end
    else
      self.where(:user_id => user_id)
    end
  end

end
