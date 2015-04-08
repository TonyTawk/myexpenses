class Tagging < ActiveRecord::Base

  belongs_to :expense
  belongs_to :tag

  validates_uniqueness_of :tag_id, :scope => :expense_id


end
