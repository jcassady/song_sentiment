require 'sentimental'
require 'gemoji'

class Song
  EMOJI_MAPPING = {positive: :smile,
                   neutral: :expressionless,
                   negative: :worried}.freeze

  def initialize(lyrics:)
    @lyrics   = lyrics
    @analyzer = Sentimental.new
    @analyzer.load_defaults
  end

  def emoji_lyrics
    lyrics_string = ''
    lyrics_with_emoji.each_pair do |lyric, emoji|
      lyrics_string << lyric + ' ' + emoji + "\n"
    end
    lyrics_string
  end

  private

  def lyrics_with_emoji
    lyrics_with_sentiments.transform_values do |sentiment|
      Emoji.find_by_alias(EMOJI_MAPPING.fetch(sentiment).to_s).raw
    end
  end

  def lyrics_with_sentiments
    sentiments = []
    lyrics = @lyrics.split("\n").reject!(&:empty?)
    lyrics.each do |lyric|
      sentiments << @analyzer.sentiment(lyric)
    end
    lyrics.zip(sentiments).to_h
  end
end