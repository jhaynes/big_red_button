require_relative 'client'

class BigRedButton
  def initialize(url, path, client_type='consul')
    @client_type = client_type
    @url = url
    @path = path
    
    case @client_type
    when 'consul'
      @client = DiplomatClient.new(@url, @path)
    end
  end

  def status
    @client.get
  end
  
  def pushed?
    @client.get == 'pressed'
  end

  def pushit
    @client.put('pressed')
  end

  def unpushit
    @client.put('unpressed')
  end
end
