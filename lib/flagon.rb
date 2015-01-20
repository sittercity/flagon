require 'flagon/inspector'
require 'flagon/loader/file_loader'
require 'flagon/loader/hash_loader'
require 'flagon/loader/env_loader'

module Flagon
  def self.configure(configuration = nil)
    @inspector = case configuration
    when String
      Inspector.new(file_loader(configuration))
    when Hash
      Inspector.new(hash_loader(configuration))
    else
      Inspector.new(env_loader)
    end
  end

  def self.enabled?(flag_name)
    check_initialized
    @inspector.enabled?(flag_name)
  end

  def self.when_enabled(flag_name, &block)
    check_initialized
    @inspector.when_enabled(flag_name, &block)
  end

  class NotInitialized < Exception
  end

  private

  def self.file_loader(path)
    Loader::FileLoader.new(path)
  end

  def self.hash_loader(init_hash)
    Loader::HashLoader.new(init_hash)
  end

  def self.env_loader
    Loader::EnvLoader.new
  end

  def self.check_initialized
    raise NotInitialized unless @inspector
  end
end
