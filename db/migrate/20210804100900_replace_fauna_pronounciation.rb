class ReplaceFaunaPronounciation < ActiveRecord::Migration[6.0]
  def up
    # setup
    this_user = User.find_by_name('Fundashon Pro Bista Studio Bo Buki Ku Un Bos') || User.first

    mp3_dir = '/tmp/mp3_fauna'
    raise "mp3_dir bestaat niet: #{mp3_dir}" unless File.directory? mp3_dir

    Word.is_fauna.each do |word|
      picture = word.pictures.first
      unless picture.nil?
        identifier = picture.image.palm.identifier.gsub(/\.jpg/,'')
        if File.exists?("#{mp3_dir}/#{identifier}.mp3")
          # delete old recordings
          word.recordings.each do |recording|
            if recording.name == identifier
              recording.audio.remove! # remove the file
              recording.destroy # remove the record
            end
          end
          recording = word.recordings.create(  name: identifier,
                                              user: this_user,
                                            )
          # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-%22Upload%22-from-a-local-file
          recording.audio = Pathname.new("#{mp3_dir}/#{identifier}.mp3").open
          recording.save!
          puts "*** added recording (#{word.name}: )"
        else
          puts "--- no recording (#{word.name}: )"
        end
      end
    end
  end
end
