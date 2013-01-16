require 'fox16'

include Fox

# Create the main app window...
class PictoApp < FXMainWindow

  def initialize( app )
    super app, "My Picto App", :width => 600, :height => 400
  end
    
  def create
    super
    show PLACEMENT_SCREEN
  end
  
end

# run the scripts :
if __FILE__ == $0
  FXApp.new do |app|
    PictoApp.new app
    app.create
    app.run
  end
end