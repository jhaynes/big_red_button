class DiplomatClient
  require 'diplomat'
  
  def initialize(url, path)
    @url = url
    @path = path
    Diplomat.configure do |config|
      config.url = @url
    end

    @client = Diplomat::Kv
  end
    
  def get
    begin
      @client.get(@path)
    rescue Diplomat::KeyNotFound
      warn "BigRedButton not found at #{@url} #{path}. Is it deployed there?"
    rescue Faraday::ConnectionFailed => e
      raise BigRedButtonError, "BigRedButton - Connection failed\n #{e.message}"
    end
  end

  def put(value)
    begin
      @client.put(@path, value)
    rescue Diplomat::KeyNotFound
      warn "BigRedButton not found at #{@url} #{path}. Is it deployed there?"
    rescue Faraday::ConnectionFailed => e
      raise BigRedButtonError, "BigRedButton - Connection failed\n #{e.message}"
    end
  end
end
