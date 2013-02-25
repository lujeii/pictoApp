require 'fox16'

include Fox

require_relative "./models/picture"
require_relative "./models/gallery"
require_relative "./views/galleryView"

# Main app Class.
class PictoApp < FXMainWindow

  # Constructor
  def initialize( app )

    super( app, "My Picto App", :width => 600, :height => 400 )
    @gallery = Gallery.new( 'My Pics Test' )

    pic = Picture.new( File.dirname(__FILE__) + "/images/test.png" )
    @gallery.add_picture( pic )
    @gallery.add_picture( pic )

    gallery_view = GalleryView.new( self, @gallery )
    
  end

  # Create main app window.
  def create
    super
    show( PLACEMENT_SCREEN )
  end

end

# run the app:
if __FILE__ == $0
  FXApp.new do |app|
    PictoApp.new app
    app.create
    app.run
  end
end