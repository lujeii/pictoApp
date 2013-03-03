require 'fox16'
require 'yaml'

include Fox

require_relative "./models/gallery"
require_relative "./models/galleryList"
require_relative "./views/galleryListView"
require_relative "./views/galleryView"

require_relative "./models/picture"
require_relative "./views/pictoView"

require_relative "./debug"

# Main app Class.
class PictoApp < FXMainWindow

  # Constructor
  def initialize( app )

    Debug.new( " init ")

    super( app, "My Picto App", :width => 600, :height => 400 )
    set_menu_bar

    begin
      @gallery_list = YAML.load_file( "#{File.dirname(__FILE__)}/galleries/pictoapp.yml" )
    rescue
      @gallery_list = GalleryList.new
      @gallery_list.add( Gallery.new( "My Test" ) )
    end 

    splitter = FXSplitter.new( self, :opts => SPLITTER_HORIZONTAL|LAYOUT_FILL )

    @switcher = FXSwitcher.new( splitter, :opts => LAYOUT_FILL )
    @switcher.connect( SEL_UPDATE ) do
      @switcher.current = @gallery_list_view.currentItem
    end

    @gallery_list_view = GalleryListView.new( splitter, LAYOUT_FILL )
    @gallery_list_view.switcher = @switcher
    @gallery_list_view.list = @gallery_list

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

    # new gallery cmd
    new_gallery_cmd = FXMenuCommand.new( file_menu, "New Gallery..." )
    new_gallery_cmd.connect( SEL_COMMAND ) do 
      gallery_title = FXInputDialog.getString('My Gallery', self, "New Gallery", "Name: ")
      if gallery_title
        gallery = Gallery.new( gallery_title )
        @gallery_list.add( gallery )
        @gallery_list_view.add( gallery )
        GalleryView.new( @switcher, gallery ) 
      end
    end

    # exit cmd
    exit_cmd = FXMenuCommand.new( file_menu, "Exit" )
    exit_cmd.connect( SEL_COMMAND ) do
      store_album_list
      exit
    end

  end

  def import_pics( filenames )
    filenames.each do |filename|
      pic = Picture.new( filename )
      current_gallery.add_picture( pic )
      current_gallery_view.add_pic( pic )
    end
    current_gallery_view.create
  end

  def current_gallery_view
    @switcher.childAtIndex( @switcher.current )
  end

  def current_gallery
    current_gallery_view.gallery
  end

  def store_gallery_list
    File.open( "../galleries/pictoapp.yml", "w" ) do |io|
      io.write( YAML.dump( @gallery_list ) )
    end
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