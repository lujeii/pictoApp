class PictoView < FXImageFrame

  # Const:
  MAX_WIDTH  = 200
  MAX_HEIGHT = 200

  # Constructor
  def initialize( p, pic )
    super( p, nil )
    load_pic( pic.path )
  end

  # load a pic from path given.
  def load_pic( path )
    File.open( path, "rb" ) do |io|
      self.image = FXPNGImage.new( app, io.read )
      scale_to_thumbnail
    end
  end

  # get "good" width between the args and the const
  def scaled_width( width )
    [width, MAX_WIDTH].min
  end

  # return the good value of the height between the args and the max values setted.
  def scaled_height( height )
    [height, MAX_HEIGHT].min
  end

  # scale: do the job.
  def scale_to_thumbnail

    ratio = image.width.to_f/image.height

    if ratio.to_i > 1
      x = scaled_width( image.width )
      y = y/ratio
    else 
      y = scaled_height( image.height )
      x = y*ratio
    end

    image.scale( x, y )

  end

end