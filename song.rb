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

  def lyrics_sentiment
    ratings = []
    lines = @lyrics.split("\n").reject!(&:empty?)
    lines.each do |line|
      ratings << @analyzer.sentiment(line)
    end
    lines.zip(ratings)
  end
end