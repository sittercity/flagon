module Flagon
  module Loader
    class EnvLoader
      def exists?(flag_name)
        key = to_key(flag_name)
        !(ENV[key].nil? || ENV[key].empty?)
      end

      def get_flag(flag_name)
        ENV[to_key(flag_name)] == 'on'
      end

      private

      def to_key(flag_name)
        flag_name.upcase.to_s
      end
    end
  end
end
