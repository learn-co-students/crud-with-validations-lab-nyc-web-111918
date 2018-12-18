class Song < ActiveRecord::Base
  validates :title, {presence: true}
  validates :released, inclusion: { in: [true, false]}
  validates :release_year, numericality: {less_than: Time.now.year.to_i}, if: :released
  validates :artist_name, {presence: true}
  validate :cannot_release_same_song_same_year

  def cannot_release_same_song_same_year
    songs_in_year=Song.where(release_year: self.release_year)
    same_release=songs_in_year.select{|song|song.title==self.title}
    if same_release.any? && same_release[0].id!=self.id
      errors.add(:title, "Can't release a song in a year it's already been released")
    end
  end
end
