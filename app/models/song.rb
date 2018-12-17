class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :release_year, numericality: {less_than: 2018},if: :is_released?
  validates :artist_name, uniqueness: {scope: :title }

  def is_released?
    released == true
  end
end
