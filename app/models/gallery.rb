# Gallery Model
class Gallery

  # Gallery title attribure
  attr_reader :title

  # Constructor
  def initialize( title )
    @title = title
    @pictures = []
  end

  # Add picture to gallery
  def add_picture( picture )
    @pictures << picture
  end

  # display/render each picture
  def each_picture
    @pictures.each {|pic| yield pic }
  end

end