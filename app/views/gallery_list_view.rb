class GalleryListView < FXList

  attr_reader :gallery_list

  def initialize( p, opts)
    super( p, :opts => opts )
  end

  def add_gallery( gallery )
    appendItem( gallery.title )
    GalleryView.new( @switcher, gallery )
  end

  def gallery_list=( galleries )
    @gallery_list = galleries
    @gallery_list.each_gallery {|gallery| add_gallery( gallery ) }
  end

  def switcher=( sw )
    @switcher = sw
  end

end