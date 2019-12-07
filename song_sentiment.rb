require_relative 'song'

skies_cascade = File.read('lyrics/as_the_skies_cascade.txt')
song = Song.new(lyrics: skies_cascade)
p song.sentiment