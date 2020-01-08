require("rspec")
require('spec_helper')

# describe '#Album' do

#   before(:each) do
#     Album.clear()
#     Song.clear()
#   end

describe('#==') do
  it("is the same album if it has the same attributes as another album") do
    album = Album.new({:name => "Blue", :id => nil, :year => nil, :genre => nil, :artist => nil})
    album2 = Album.new({:name => "Blue", :id => nil, :year => nil, :genre => nil, :artist => nil})
    expect(album).to(eq(album2))
  end
end


describe(".all") do
  it("returns an empty array when there are no albums") do
    expect(Album.all()).to(eq([]))
  end
end

describe('#save') do
  it("saves an album") do
    album = Album.new({:name => "Giant Steps", :id => nil, :year => nil, :genre => nil, :artist => nil})
    album.save()
    album2 = Album.new({:name => "Blue", :id => nil, :year => nil, :genre => nil, :artist => nil})
    album2.save()
    expect(Album.all).to(eq([album, album2]))
  end
end

describe('.clear') do
  it("clears all albums") do
    album = Album.new({:name => "Giant Steps", :id => nil})
    album.save()
    album2 = Album.new({:name => "Blue", :id => nil})
    album2.save()
    Album.clear()
    expect(Album.all).to(eq([]))
  end
end

describe('.find') do
  it("finds an album by id") do
    album = Album.new({:name => "Giant Steps", :id => nil})
    album.save()
    album2 = Album.new({:name => "Blue", :id => nil})
    album2.save()
    expect(Album.find(album.id)).to(eq(album))
  end
end

describe('#update') do
  it("updates an album by id") do
    album = Album.new({:name => "Giant Steps", :id => nil, :year => nil, :genre => nil, :artist => nil})
    album.save()
    album.update("A Love Supreme", 1994, "Jazz", "Alice Coltrane")
    expect(album.name).to(eq("A Love Supreme"))
    expect(album.year).to(eq(1994))
  end
end

describe('#delete') do
  it("deletes an album by id") do
    album = Album.new({:name => "Giant Steps", :id => nil})
    album.save()
    album2 = Album.new({:name => "Blue", :id => nil})
    album2.save()
    album.delete()
    expect(Album.all).to(eq([album2]))
  end
end

describe('.search') do
  it("Searches for matching albums by name") do
    album1 = Album.new({:name => "Giant Steps", :id => nil})
    album1.save()
    album2 = Album.new({:name => "Blue", :id => nil})
    album2.save()
    album3 = Album.new({:name => "Green Steps", :id => nil})
    album3.save()
    expect(Album.search("Steps")).to(eq([album1,album3]))
  end
end

describe('.sort') do
  it('sorts by alphebetical order') do
    album1 = Album.new({:name => "Giant Steps", :id => nil})
    album1.save()
    album2 = Album.new({:name => "Blue", :id => nil})
    album2.save()
    album3 = Album.new({:name => "Green Steps", :id => nil})
    album3.save()
    expect(Album.sort()).to(eq([album2, album1, album3]))
  end
end

describe('#songs') do
  it("returns an album's songs") do
    album = Album.new({:name => "Giant Steps", :id => nil})
    album.save()
    song = Song.new({:name => "Naima", :album_id => album.id, :id => nil})
    song.save()
    song2 = Song.new({:name => "Cousin Mary", :album_id => album.id, :id => nil})
    song2.save()
    expect(album.songs).to(eq([song, song2]))
  end
end
#
# # describe('#sold') do
# #   it('sorts by alphebetical order') do
# #   album1 = Album.new("Giant Steps", nil, nil, nil, nil)
# #   album1.save()
# #   album2 = Album.new("Blue", nil, nil, nil, nil)
# #   album2.save()
# #   album3 = Album.new("Green Steps", nil, nil, nil, nil)
# #   album3.save()
# #   album2.sold()
# #
# #   expect(@@sold_albums).to(eq([album2]))
# # end
# # end
#
#
# end
#
# end
