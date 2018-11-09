require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :genre, :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.create(name, artist = nil, genre = nil)
    obj = self.new(name, artist, genre)
    obj.save
    obj
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    data_raw = filename.split(".mp3")
    data = data_raw[0].split(" - ")
    song = Song.find_or_create_by_name(data[1])
    song.genre = Genre.find_or_create_by_name(data[2])
    song.artist = Artist.find_or_create_by_name(data[0])
    song.artist.songs << song
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end