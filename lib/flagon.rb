require 'flagon/inspector'
require 'flagon/loader/file_loader'

module Flagon
  def self.configure(configuration = nil)
    case configuration
    when String
      Inspector.new(file_loader(configuration))
    when Hash
      Inspector.new(hash_loader(configuration))
    else
      Inspector.new(env_loader)
    end
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
end
