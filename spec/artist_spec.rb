require ('spec_helper')
require 'pry'
require 'rspec'

describe '#Artist' do
  before(:each) do
    Artist.clear()
    Song.clear()
    Album.clear()
    @artist = Artist.new({:name => 'John Coltrane', :id => nil})
    @artist.save()
  end

  describe('#==') do
    it('is the same artist if it has the same attributes as another artist') do
      artist2 = Artist.new({:name => 'John Coltrane', :id => nil})
      artist2.save()
      artist3 = Artist.new({:name => 'Kamasi Washington', :id => nil})
      artist3.save()
      expect(@artist).to(eq(artist2))
      expect(@artist).not_to(eq(artist3))
    end

  end

  describe('#update') do
    it('adds an album to an artist') do
      artist = Artist.new({:name => 'John Coltrane', :id => nil})
      artist.save()
      album = Album.new({:name => 'A Love Supreme', :id => nil})
      album.save()
      artist.update({:album_name => 'A Love Supreme'})
      expect(artist.albums).to(eq([album]))
    end

    it('updates an artist by id') do
      artist = Artist.new({:name => 'Wu-Tang Clan', :id => nil})
      artist.save()
      artist.update({:name => "A Tribe Called Quest"})
      expect(artist.name).to(eq("A Tribe Called Quest"))
    end
  end

  describe('#save') do
    it('saves an artist') do
      artist2 = Artist.new({:name => 'John Coltrane', :id => nil})
      artist2.save()
      expect(Artist.all).to(eq([@artist, artist2]))
    end
  end

  describe('.clear') do
    it('clears all artists') do
      artist = Artist.new({:name => 'Bob Dylan', :id => nil})
      artist2 = Artist.new({:name => 'Wu-Tang Clan', :id => nil})
      artist.save()
      artist2.save()
      Artist.clear()
      expect(Artist.all).to(eq([]))
    end
  end

  describe('find') do
    it('finds and artist by id') do
      artist = Artist.new({:name => 'John Coltrane', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Theolonius Monk', :id => nil})
      artist2.save()
      expect(Artist.find(artist.id)).to(eq(artist))
      expect(Artist.find(artist2.id)).to(eq(artist2))
    end
  end

end
