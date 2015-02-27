module Flagon
  class Inspector
    attr_reader :loader

    def initialize(loader)
      @loader = loader
    end

    def enabled?(flag_name)
      return false unless exists?(flag_name)
      get_flag(flag_name)
    end

    def when_enabled(flag_name)
      if enabled?(flag_name)
        yield
      end
    end

    def ensure_flags_exist(*flags)
      missing_flags = flags.select do |flag_name|
        !exists?(flag_name)
      end
      raise FlagMissing, "The following flags are missing: #{missing_flags.join(', ')}" unless missing_flags.empty?
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
