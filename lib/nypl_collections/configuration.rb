module Collections
  module Configuration
    
    attr_accessor :auth_token

    def configure
      yield self
    end

    def reset
      self.auth_token = nil
      self
    end
  end
end