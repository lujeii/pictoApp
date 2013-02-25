require_relative 'pictoView'

class GalleryView < FXMatrix

  # attributes set up
  attr_reader :gallery

  # Constructor
  def initialize( p, gallery )
    super( p, :opts => LAYOUT_FILL )
    @gallery = gallery
    @gallery.each_picture {|pic| add_pic(pic) }
  end
  
  # add picto view in this gallery
  def add_pic( pic )
    PictoView.new( self, pic )
  end
  
end