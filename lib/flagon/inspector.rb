module Flagon
  class Inspector
    attr_reader :loader

    def initialize(loader)
      @loader = loader
    end

    def enabled?(flag_name)
      raise FlagMissing, "The flag #{flag_name} is missing" unless exists?(flag_name)
      get_flag(flag_name)
    end

    def when_enabled(flag_name)
      if enabled?(flag_name)
        yield
      end
    end

    class FlagMissing < Exception
    end

    private

    def get_flag(flag_name)
      loader.get_flag(flag_name)
    end

    def exists?(flag_name)
      loader.exists?(flag_name)
    end
  end
end
