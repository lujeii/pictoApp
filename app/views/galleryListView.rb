class GalleryListView < FXList

  attr_reader :gallery_list

  def initialize( p, opts)
    super( p, :opts => opts )
  end

  def add( gallery )
    appendItem( gallery.title )
    GalleryView.new( @switcher, gallery )
  end

  def list=( galleries )
    @gallery_list = galleries
    @gallery_list.each_gallery {|gallery| add( gallery ) }
  end

  def switcher=( sw )
    @switcher = sw
  end

end