class CleanupLicenseAndArtist < ActiveRecord::Migration[6.0]
  def up
    flora_fauna_license = License.find_by_name('CC BY-NC-SA 4.0')
    music_license = License.find_by_name('CC BY-SA 3.0')
    Word.has_pictures.is_fauna.each do |word|
      p = word.pictures.first
      p.license = flora_fauna_license
      p.artist = nil # no artist because it will default to user that created it
      p.save
    end
    Word.has_pictures.is_flora.each do |word|
      p = word.pictures.first
      p.license = flora_fauna_license
      p.artist = nil # no artist because it will default to user that created it
      p.save
    end
    Word.has_pictures.is_music.each do |word|
      p = word.pictures.first
      p.license = music_license
      p.artist = nil # no artist because it will default to user that created it
      p.save
    end
  end
end
