class GalleryListView < FXList

  attr_reader :gallery_list

  def initialize( p, opts, gallery_list )
    super( p, :opts => opts )
    @gallery_list.each_gallery {|gallery| add( gallery ) }
  end

  def add( gallery )
    appendItem( gallery.title )
  end

end