module Flagon
  module Loader
    class HashLoader
      def initialize(init_hash)
        @flags = init_hash.each_with_object({}) do |kv,flags|
          flags[to_key(kv[0])] = (kv[1] == 'on')
        end
      end

      def exists?(flag_name)
        flags.has_key?(to_key(flag_name))
      end

      def get_flag(flag_name)
        flags[to_key(flag_name)]
      end

      private

      def to_key(flag_name)
        flag_name.upcase.to_sym
      end

      attr_reader :flags
    end
  end
end
