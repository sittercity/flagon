require 'flagon/inspector'
require 'flagon/loader/file_loader'
require 'flagon/loader/hash_loader'
require 'flagon/loader/env_loader'

module Flagon
  class << self
    def init(configuration = nil)
      @inspector = case configuration
                   when String
                     Inspector.new(file_loader(configuration))
                   when Hash
                     Inspector.new(hash_loader(configuration))
                   else
                     Inspector.new(env_loader)
                   end
    end

    def enabled?(flag_name)
      check_initialized
      @inspector.enabled?(flag_name)
    end

    def when_enabled(flag_name, &block)
      check_initialized
      @inspector.when_enabled(flag_name, &block)
    end

    private

    def file_loader(path)
      Loader::FileLoader.new(path)
    end

    def hash_loader(init_hash)
      Loader::HashLoader.new(init_hash)
    end

    def env_loader
      Loader::EnvLoader.new
    end

    def check_initialized
      raise NotInitialized unless @inspector
    end
  end

  class NotInitialized < Exception
  end
end
