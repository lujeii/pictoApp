require 'fox16'

include Fox

require_relative "./models/picture"
require_relative "./pictoView"

# Main app Class.
class PictoApp < FXMainWindow

  # Constructor
  def initialize( app )
    super( app, "My Picto App", :width => 600, :height => 400 )
    pic = Picture.new( File.dirname(__FILE__) + "/images/test.png" )
    picto_view = PictoView.new( self, pic )
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