class Category < ActiveRecord::Base
  before_save :set_url_name

  has_many :expenses

  private

  def set_url_name
    unless self.name.nil?
      self.url_name = self.name.downcase.tr(" ", "_")
    end
  end

end
