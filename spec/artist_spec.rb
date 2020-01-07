require ('spec_helper')
require 'pry'
require 'rspec'

describe '#Artist' do
  before(:each) do
    Artist.clear()
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
end

end
