# Gallery List model
class GalleryList

  # Constructor
  def initialize
    @galleries = []
  end

  # add a gallery to list
  def add( gallery )
    @galleries << gallery
  end

  # remove a gallery to list
  def remove( gallery )
    @galleries.delete( gallery )
  end

  #
  def each_gallery
    @galleries.each {|gallery| yield gallery }
  end

end