require 'sentimental'

class Song
  def initialize(lyrics:)
    @lyrics   = lyrics
    @analyzer = Sentimental.new
    @analyzer.load_defaults
  end

  def sentiment
    @analyzer.sentiment @lyrics
  end

  def score
    @analyzer.score @lyrics
  end
end