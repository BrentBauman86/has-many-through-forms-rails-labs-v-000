class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :comments, reject_if: proc {|attributes| attributes.all? { |key, value| key == "_destroy" || value.blank?}}

  def comment_attributes=(comment_attributes)
    comment_attributes.values.each do |comment_attribute|
      comment = Comment.find_or_create_by(comment_attribute)
      self.comments << comment 
    end
  end

end
