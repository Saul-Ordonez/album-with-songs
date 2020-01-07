class Album
  attr_accessor :name, :id, :year, :genre, :artist

  def initialize(attributes) ##CHANGE # We've added id as a second parameter.
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @year = attributes.fetch(:year, nil)
    @genre = attributes.fetch(:genre, nil)
    @artist = attributes.fetch(:artist, nil)
  end

  def self.all
    returned_albums = DB.exec('SELECT * FROM albums;')
    albums = []
    returned_albums.each() do |album|
      name = album.fetch('name')
      id = album.fetch('id').to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def self.search(x)
    albums = Album.all
    albums.select {|e| /#{x}/i.match? e.name}
  end

  def save
    result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    year = album.fetch("year")
    genre = album.fetch("genre")
    artist = album.fetch("artist")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id, :year => year, :genre => genre, :artist => artist})
  end

  def update(name, year, genre, artist)
    @name = (name != '') ? name : @name
    @year = (year != '') ? year : @year
    @genre = (genre != '') ? genre : @genre
    @artist = (artist != '') ? artist : @artist
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE albums SET year = '#{@year}' WHERE id = #{@id};")
    DB.exec("UPDATE albums SET genre = '#{@genre}' WHERE id = #{@id};")
    DB.exec("UPDATE albums SET artist = '#{@artist}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end

  def self.sort()
    albums = Album.all
    albums.sort { |a, b| a.name <=> b.name }
    # @@albums.values()
  end

  def songs
    Song.find_by_album(self.id)
  end

  # def sold()
  #   @@sold_albums[self.id].push(@@albums[self.id] = Album.new(self.name, self.id, self.year, self.genre, self.artist))
  #   @@albums.delete(self.id)
  #   # @@albums.values()
  # end


end
