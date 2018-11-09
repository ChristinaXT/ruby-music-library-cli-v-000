require 'pry'

class Genre
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

  def artists
    response = @songs.collect {|song| song.artist}
    response.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end