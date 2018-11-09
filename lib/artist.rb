require 'pry'

class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres
    response = @songs.collect {|song| song.genre}
    response.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end