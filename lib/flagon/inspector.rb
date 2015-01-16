require 'forwardable'

module Flagon
  class Inspector
    extend Forwardable

    attr_reader :loader

    def initialize(loader)
      @loader = loader
    end

    def check_flag(flag_name)
      raise FlagMissing, "The flag #{flag_name} is missing" unless exists?(flag_name)
      get_flag(flag_name)
    end

    def if_enabled(flag_name)
      if check_flag(flag_name)
        yield
      end
    end

    class FlagMissing < Exception
    end

    private

    def_delegators :loader, :get_flag, :exists?
  end
end
