class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def review_average
    return 0 if reviews.empty?
    reviews.average(:rating)
  end 

  def best_reviews 
    reviews.order("rating desc")[0..2]
  end

  def worst_reviews 
    reviews.order(:rating)[0..2]
  end
end
