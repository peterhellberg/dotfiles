if defined? IRB
  IRB.conf[:PROMPT_MODE]  = :SIMPLE
  IRB.conf[:USE_READLINE] = true
end

if defined? Pry
  Pry.config.prompt_name = File.basename(Dir.pwd)
  Pry.config.should_load_plugins = false
  Pry.config.pager = false
  Pry.config.editor = "vim"
end

def redis_url(url)
  require 'redis'
  require 'uri'

  uri = URI.parse(url)

  Redis.new :host =>     uri.host,
            :port =>     uri.port,
            :password => uri.password
end

class Object
  def own_methods
    self.methods - Object.methods
  end
end
