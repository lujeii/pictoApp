require 'fox16'

include Fox

require_relative "./models/picture"
require_relative "./models/gallery"
require_relative "./models/galleryList"
require_relative "./views/galleryView"
require_relative "./views/galleryListView"

# Main app Class.
class PictoApp < FXMainWindow

  # Constructor
  def initialize( app )

    super( app, "My Picto App", :width => 600, :height => 400 )
    set_menu_bar

    @gallery = Gallery.new( 'My Pics Test' )
    @gallery_list = GalleryList.new
    @gallery_list.add( @gallery )

    splitter = FXSplitter.new( self, :opts => SPLITTER_HORIZONTAL|LAYOUT_FILL )
    @gallery_list_view = GalleryListView.new( splitter, LAYOUT_FILL, @gallery_list)
    @gallery_view = GalleryView.new( splitter, @gallery )

  end

  # Create main app window.
  def create
    super
    show( PLACEMENT_SCREEN )
  end

  def set_menu_bar
    
    menu_bar = FXMenuBar.new( self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X )
    file_menu = FXMenuPane.new( self )
    FXMenuTitle.new( menu_bar, "File", :popupMenu => file_menu )

    # import cmd
    import_cmd = FXMenuCommand.new( file_menu, "Import..." )
    import_cmd.connect( SEL_COMMAND ) do
      dialog = FXFileDialog.new( self, "Import Photos" )
      dialog.selectMode = SELECTFILE_MULTIPLE
      dialog.patternList =["PNG Images (*.png)"]
      import_pics( dialog.filenames ) if dialog.execute != 0
    end

    # exit cmd
    exit_cmd = FXMenuCommand.new( file_menu, "Exit" )
    exit_cmd.connect( SEL_COMMAND ) do
      exit
    end

  end

  def import_pics( filenames )

    filenames.each do |filename|
      pic = Picture.new( filename )
      @gallery.add_picture( pic )
      @gallery_view.add_pic( pic )
    end
    @gallery_view.create
    
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