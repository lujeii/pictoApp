class PictoView < FXImageFrame

  # Constructor
  def initialize( p, pic )
    super( p, nil )
    load_pic( pic.path )
  end

  # load a pic from path given.
  def load_pic( path )
    File.open( path, 'rb' ) do |io| 
      self.image = FXJPGImage.new( app, io.read )
    end
  end

end