require 'flagon/inspector'
require 'flagon/loader/file_loader'
require 'flagon/loader/hash_loader'
require 'flagon/loader/env_loader'

module Flagon
  class << self
    attr_reader :inspector

    # Init method takes one of the loaders listed below or a
    # custom loader that responds to the same interface
    def init(loader = env_loader)
      @inspector = Inspector.new(loader)
    end

    # Pre-defined loaders
    def env_loader
      Loader::EnvLoader.new
    end

    def file_loader(path)
      Loader::FileLoader.new(path)
    end

    def hash_loader(init_hash)
      Loader::HashLoader.new(init_hash)
    end

    # Convenience methods to allow calling Flagon.enabled? directly
    def enabled?(flag_name)
      check_initialized
      @inspector.enabled?(flag_name)
    end

    def when_enabled(flag_name, &block)
      check_initialized
      @inspector.when_enabled(flag_name, &block)
    end

    def ensure_flags_exist(*flags)
      check_initialized
      @inspector.ensure_flags_exist(*flags)
    end

    private

    def check_initialized
      raise NotInitialized unless @inspector
    end
  end

  class NotInitialized < Exception
  end
end
